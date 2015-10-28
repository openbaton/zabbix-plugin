package org.openbaton.monitoring.agent;


import com.google.gson.*;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import org.openbaton.catalogue.nfvo.Item;
import org.openbaton.monitoring.agent.exceptions.MonitoringException;
import org.openbaton.monitoring.interfaces.MonitoringPlugin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.rmi.RemoteException;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import static com.google.common.primitives.Doubles.tryParse;
import static java.lang.Thread.sleep;

/**
 * Created by mob on 22.10.15.
 */
public class ZabbixMonitoringAgent extends MonitoringPlugin {

    private String zabbixIp;
    private String zabbixURL;
    private int historyLength;
    private int requestFrequency;
    private Properties properties;
    private Gson mapper;
    private String TOKEN;
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    private String username;
    private String password;
    private String type;
    private LimitedQueue<Map<String, HistoryObject>> history;
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    public ZabbixMonitoringAgent() throws RemoteException {
        init();
    }

    @Override
    public List<Item> getMeasurementResults(List<String> hostnames, List<String> metrics, String period) throws RemoteException {
        List<Item> items = new LinkedList<Item>();
        long currTime = System.currentTimeMillis()/1000;
        long startingTime = currTime - Long.parseLong(period); // that's the point of time where requested history starts

        synchronized (history) {
            for (String host : hostnames) {

                LinkedList<HistoryObject> historyImportant = new LinkedList<HistoryObject>();  // the part of the history which lies in the period
                Iterator<Map<String, HistoryObject>> iterator = history.descendingIterator();
                // get the latest history entry
                if (iterator.hasNext())
                    historyImportant.add(iterator.next().get(host));

                while (iterator.hasNext()) {
                    HistoryObject ho = iterator.next().get(host);
                    if (ho.getTimestamp() < startingTime) {
                        break;
                    }
                    historyImportant.add(ho);
                }

                for (String metric : metrics) {
                    Iterator<HistoryObject> historyIterator = historyImportant.iterator();
                    Item item = new Item();
                    item.setHostname(host);
                    item.setMetric(metric);

                    HistoryObject hObj = historyIterator.next();
                    if (!hObj.keyExists(metric))
                        continue;

                    item.setHostId(hObj.getHostId());

                    String value = hObj.getMeasurement(metric);
                    item.setLastValue(value);

                    Double avg = (Double) tryParse(value);
                    if (avg != null) { // it is a number and no string
                        while (historyIterator.hasNext()) {
                            avg += Double.parseDouble(historyIterator.next().getMeasurement(metric));
                        }
                        avg /= historyImportant.size();
                        value = avg.toString();
                    }
                    // if the metric's value is a String, just store the last value as value
                    item.setValue(value);

                    items.add(item);
                }


            }
        }

        return items;
    }

    @Override
    public void notifyResults() {

    }

    @Override
    public String getType() {
        return type;
    }





    private Runnable updateHistory = new Runnable() {
        @Override
        public void run() {
            JsonObject responseObj = null;
            String params = "{'output': ['name'], 'selectItems': ['key_', 'lastvalue']}";
            try {
                responseObj = callPost(params, "host.get");
            } catch (MonitoringException e) {
                log.error("Exception while updating hosts:" + e.getMessage());
            }
            long timestamp = System.currentTimeMillis()/1000;
            JsonArray hostArray = responseObj.get("result").getAsJsonArray();
            Iterator<JsonElement> iterator = hostArray.iterator();


            // String is the hostname
            Map<String, HistoryObject> snapshot = new HashMap<String, HistoryObject>();
            while (iterator.hasNext()) {
                JsonObject jsonObj = iterator.next().getAsJsonObject();
                String hostName = jsonObj.getAsJsonObject().get("name").getAsString();
                JsonArray itemArray = jsonObj.get("items").getAsJsonArray();
                Iterator<JsonElement> itemIterator = itemArray.iterator();
                HistoryObject ho = new HistoryObject(timestamp);
                ho.setHostId(jsonObj.get("hostid").getAsString());
                // add the values to the HistoryObject
                while (itemIterator.hasNext()) {
                    JsonObject item = itemIterator.next().getAsJsonObject();
                    ho.setMeasurement(item.get("key_").getAsString(), item.get("lastvalue").getAsString());
                }

                snapshot.put(hostName, ho);
            }
            synchronized (history) {
                history.add(snapshot);
            }
        }
    };




    private JsonObject callPost(String content, String method) throws MonitoringException {
        HttpResponse<String> jsonResponse = null;

        String body= prepareJson(content,method);
        try {
            jsonResponse = Unirest.post(zabbixURL).header("Content-type","application/json-rpc").header("KeepAliveTimeout","5000").body(body).asString();
        } catch (UnirestException e) {
            log.error("Post on the Zabbix server failed",e);
        }
        if(checkAuthorization(jsonResponse.getBody()))
        {
            this.TOKEN = null;
			/*
			 * authenticate again, because the last token is expired
			 */
            authenticate(zabbixIp, username, password);
            body = prepareJson(content, method);
            try {
                jsonResponse = Unirest.post(zabbixURL).header("Content-type","application/json-rpc").header("KeepAliveTimeout","5000").body(body).asString();
            } catch (UnirestException e) {
                log.error("Post on the Zabbix server failed",e);
            }
        }
        log.debug("Response received: " + jsonResponse);

        JsonObject responseOb = mapper.fromJson(jsonResponse.getBody(), JsonObject.class);
        if(responseOb == null)
            throw new MonitoringException();

        return responseOb;
    }


    /**
     *
     * @param body
     * @return true if not authorized
     */
    private boolean checkAuthorization(String body) {
        boolean isAuthorized = false;
        JsonElement error;
        JsonElement data = null;
        JsonObject responseOb;

        responseOb=mapper.fromJson(body, JsonObject.class);

        if(responseOb == null){
            return isAuthorized;
        }

        log.debug("Check authorization in this response:" + responseOb);

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

    private String prepareJson (String content, String method){

        String s = "{'params': "+content+"}";

        JsonObject jsonContent = mapper.fromJson(s, JsonObject.class);
        JsonObject jsonObject = jsonContent.getAsJsonObject();



        jsonObject.addProperty("jsonrpc","2.0");
        jsonObject.addProperty("method", method);

        if(TOKEN!=null)
            jsonObject.addProperty("auth",TOKEN);
        jsonObject.addProperty("id", 1);

        log.debug("Json for zabbix:\n" + mapper.toJson(jsonObject));
        return mapper.toJson(jsonObject);
    }

    private void init() throws RemoteException {
        properties=new Properties();
        try {
            properties.load(new FileInputStream(new File("src/main/resources/plugin.conf.properties")));
        } catch (IOException e) {
            log.error("Config file not found");
            throw new RemoteException("Config file not found");
        }
        zabbixIp=properties.getProperty("zabbix-ip");
        zabbixURL=zabbixIp+"/zabbix/api_jsonrpc.php";
        username=properties.getProperty("user");
        password=properties.getProperty("password");
        type = properties.getProperty("type");
        requestFrequency = Integer.parseInt(properties.getProperty("client-request-frequency"));
        historyLength = Integer.parseInt(properties.getProperty("history-length"));
        history = new LimitedQueue<Map<String, HistoryObject>>(historyLength);
        mapper=new GsonBuilder().setPrettyPrinting().create();
        try {
            authenticate(zabbixIp, username, password);
        } catch (MonitoringException e) {
            log.error("Authentication failed: " + e.getMessage());
        }


        scheduler.scheduleAtFixedRate(updateHistory, 0, requestFrequency, TimeUnit.SECONDS);

        try {
            sleep(3000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }


    }

    /**
     * terminate the scheduler safely
     */
    public void terminate() {
        shutdownAndAwaitTermination(scheduler);
    }


    public void authenticate(String zabbixIp, String username, String password) throws MonitoringException {
        this.zabbixIp = zabbixIp;
        this.username = username;
        this.password = password;

        this.authenticate();
    }

    private void authenticate() throws MonitoringException {
        String params = "{'user':'"+username+"','password':'"+password+"'}";

        JsonObject responseObj = callPost(params, "user.login");
        JsonElement result = responseObj.get("result");
        if(result == null) {
            throw new MonitoringException("problem during the authentication");
        }
        this.TOKEN = result.getAsString();

        log.debug("Authenticated to Zabbix Server " + zabbixURL + " with TOKEN " + TOKEN);
    }


    void shutdownAndAwaitTermination(ExecutorService pool) {
        pool.shutdown(); // Disable new tasks from being submitted
        try {
            // Wait a while for existing tasks to terminate
            if (!pool.awaitTermination(60, TimeUnit.SECONDS)) {
                pool.shutdownNow(); // Cancel currently executing tasks
                // Wait a while for tasks to respond to being cancelled
                if (!pool.awaitTermination(60, TimeUnit.SECONDS))
                    System.err.println("Pool did not terminate");
            }
        } catch (InterruptedException ie) {
            // (Re-)Cancel if current thread also interrupted
            pool.shutdownNow();
            // Preserve interrupt status
            Thread.currentThread().interrupt();
        }
    }

}
