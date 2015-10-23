package org.openbaton.monitoring.agent;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import org.openbaton.catalogue.mano.record.VNFCInstance;
import org.openbaton.catalogue.nfvo.Item;
import org.openbaton.monitoring.interfaces.Monitoring;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.Properties;

/**
 * Created by mob on 22.10.15.
 */
public class ZabbixMonitoringAgent extends Monitoring{

    private String zabbixIp;
    private String zabbixURL;
    private Properties properties;
    private Gson mapper;
    private String TOKEN;
    protected Logger log = LoggerFactory.getLogger(this.getClass());

    protected ZabbixMonitoringAgent() throws RemoteException {
        init();
    }

    @Override
    public Item getMeasurementResults(VNFCInstance vnfcInstance, String metric, String period) {
        return null;
    }

    @Override
    public void notifyResults() {

    }

    @Override
    public String getType() {
        return null;
    }

    private JsonObject callPost(String content, String method){
        HttpResponse<String> jsonResponse = null;

        String body= prepareJson(content,method);

        try {
            jsonResponse = Unirest.post(zabbixURL).header("Content-type","application/json-rpc").header("KeepAliveTimeout","5000").body(body).asString();
        } catch (UnirestException e) {
            log.error("Post on the Zabbix server failed",e);
        }

        //if(checkAuthorization(jsonResponse.getBody()))
        //TODO continue from here
        return null;
    }

    private boolean checkAuthorization(String body) {
        boolean isUnauthorized = false;
        String error;
        JsonElement responseEl;

        responseEl=mapper.fromJson(body, JsonElement.class);

        log.debug("Check authorization in this response:"+responseEl);

        if(responseEl.isJsonObject()){
            JsonObject responseObj=(JsonObject) responseEl;

        }

        return false;
    }

    private String prepareJson (String content, String method){

        JsonObject jsonObject = new JsonObject();

        JsonElement jsonContent = mapper.fromJson(content, JsonElement.class);

        jsonObject.add("params", jsonContent);

        jsonObject.addProperty("jsonrpc","2.0");
        jsonObject.addProperty("method", method);

        if(TOKEN!=null)
            jsonObject.addProperty("auth",TOKEN);
        jsonObject.addProperty("id",1);

        log.debug("Json for zabbix:\n"+mapper.toJson(jsonObject));

        return mapper.toJson(jsonObject);
    }

    private void init() throws RemoteException {
        properties=new Properties();
        try {
            properties.load(new FileInputStream(new File("plugin.conf.properties")));
        } catch (IOException e) {
            log.error("Config file not found");
            throw new RemoteException("Config file not found");
        }
        zabbixIp=properties.getProperty("zabbixIp");
        zabbixURL="http://"+zabbixIp+"/zabbix/api_jsonrpc.php";
        mapper=new GsonBuilder().setPrettyPrinting().create();

    }

    private void authenticate(){
        //TODO
    }

}
