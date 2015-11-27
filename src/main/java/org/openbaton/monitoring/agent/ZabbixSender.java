package org.openbaton.monitoring.agent;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.mashape.unirest.http.HttpMethod;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import org.openbaton.exceptions.MonitoringException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Created by mob on 18.11.15.
 */
public class ZabbixSender {

    private Logger log = LoggerFactory.getLogger(this.getClass());
    private Gson mapper=new GsonBuilder().setPrettyPrinting().create();
    private String TOKEN;
    private String zabbixIp;
    private String zabbixPort;
    private String zabbixURL;
    private String username;
    private String password;

    public ZabbixSender(String zabbixIp,String zabbixPort, String username, String password){
        this.zabbixIp=zabbixIp;
        this.username=username;
        this.password=password;
        if (zabbixPort == null || zabbixPort.equals("")) {
            zabbixURL = "http://" + zabbixIp + "/zabbix/api_jsonrpc.php";
        }
        else {
            zabbixURL = "http://" + zabbixIp + ":" + zabbixPort + "/zabbix/api_jsonrpc.php";
            this.zabbixPort=zabbixPort;
        }
    }
    public synchronized HttpResponse<String> doRestCallWithJson(String url,String json,HttpMethod method,String contentType) throws UnirestException {
        HttpResponse<String> response=null;
        switch (method){
            case PUT : response=Unirest.put(url).header("Content-type",contentType).header("KeepAliveTimeout","5000").body(json).asString();
                break;
            case POST: response=Unirest.post(url).header("Content-type",contentType).header("KeepAliveTimeout","5000").body(json).asString();
                break;
        }
        return response;
    }

    public JsonObject callPost(String content, String method) throws MonitoringException {
        HttpResponse<String> jsonResponse = null;

        String body = prepareJson(content, method);
        try {
            jsonResponse = doRestCallWithJson(zabbixURL, body, HttpMethod.POST, "application/json-rpc");
            if (checkAuthorization(jsonResponse.getBody())) {
                this.TOKEN = null;
            /*
			 * authenticate again, because the last token is expired
			 */
                authenticate(zabbixIp, username, password);
                body = prepareJson(content, method);
                jsonResponse = doRestCallWithJson(zabbixURL, body, HttpMethod.POST, "application/json-rpc");
            }
            //log.debug("Response received: " + jsonResponse);
        } catch (UnirestException e) {
            log.error("Post on the Zabbix server failed", e);
            throw new MonitoringException(e.getMessage(), e);
        }
        JsonElement responseEl = mapper.fromJson(jsonResponse.getBody(), JsonObject.class);
        if (responseEl == null || !responseEl.isJsonObject())
            throw new MonitoringException("The json received from Zabbix Server is not a JsonObject or null");
        JsonObject responseObj= responseEl.getAsJsonObject();

        if(responseObj.get("error")!=null){
            JsonObject errorObj=(JsonObject) responseObj.get("error");
            throw new MonitoringException(errorObj.get("message").getAsString()+" "+errorObj.get("data").getAsString());
        }
        return responseObj;
    }

    private String prepareJson (String content, String method){

        String s = "{'params': "+content+"}";

        JsonObject jsonContent = mapper.fromJson(s, JsonObject.class);
        JsonObject jsonObject = jsonContent.getAsJsonObject();



        jsonObject.addProperty("jsonrpc","2.0");
        jsonObject.addProperty("method", method);

        if(TOKEN!=null)
            jsonObject.addProperty("auth",TOKEN);
        jsonObject.addProperty("id", 1);

        //log.debug("Json for zabbix:\n" + mapper.toJson(jsonObject));
        return mapper.toJson(jsonObject);
    }

    private boolean checkAuthorization(String body) {
        boolean isAuthorized = false;
        JsonElement error;
        JsonElement data = null;
        JsonObject responseOb;

        responseOb=mapper.fromJson(body, JsonObject.class);

        if(responseOb == null){
            return isAuthorized;
        }

        //log.debug("Check authorization in this response:" + responseOb);

        error = responseOb.get("error");
        if(error == null) {
            return isAuthorized;
        }
        //log.debug("AUTHENTICATION ERROR  ----->   "+error + " ---> Retrying");

        if(error.isJsonObject())
            data = ((JsonObject)error).get("data");

        if(data.getAsString().equals("Not authorized")) {
            isAuthorized = true;
            return isAuthorized;
        }

        return false;
    }

    public void authenticate(String zabbixIp, String username, String password) throws MonitoringException {
        this.zabbixIp = zabbixIp;
        this.username = username;
        this.password = password;

        this.authenticate();
    }

    public void authenticate() throws MonitoringException {
        String params = "{'user':'"+username+"','password':'"+password+"'}";

        JsonObject responseObj = callPost(params, "user.login");
        JsonElement result = responseObj.get("result");
        if(result == null) {
            throw new MonitoringException("problem during the authentication");
        }
        this.TOKEN = result.getAsString();

        //log.debug("Authenticated to Zabbix Server " + zabbixURL + " with TOKEN " + TOKEN);
    }
}
