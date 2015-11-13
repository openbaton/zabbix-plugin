package org.openbaton.monitoring.agent;


import com.google.gson.*;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import org.openbaton.catalogue.nfvo.Item;
import org.openbaton.monitoring.agent.exceptions.MonitoringException;
import org.openbaton.monitoring.interfaces.MonitoringPlugin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.InetSocketAddress;
import java.rmi.RemoteException;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import static com.google.common.primitives.Doubles.tryParse;

/**
 * Created by mob on 22.10.15.
 */
public class ZabbixMonitoringAgent extends MonitoringPlugin {

    private String zabbixIp;
    private String zabbixPort;
    private String zabbixURL;
    private int historyLength;
    private int requestFrequency;
    private Gson mapper;
    private String TOKEN;
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    private String username;
    private String password;
    private String type;
    private LimitedQueue<State> history;
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    //Server properties
    private HttpServer server;
    private MyHandler myHandler;
    //

    public ZabbixMonitoringAgent() throws RemoteException {
        init();
        try {
            launchServer();
        } catch (IOException e) {
            throw new RemoteException(e.getMessage(),e);
        }
    }

    /**
     * @param hostnames a list of hostnames
     * @param metrics a list of the metrics that shall be retrieved from every hostname
     * @param period you get for every suitable metric the average value it had for the last <period> seconds of time
     * @return a list of Items
     * @throws RemoteException
     *
     * The method gives back a list of Items.
     * For every combination of hostname and metric, one Item will be in the list.
     * Every Item contains the hostname, the host id, the latest value of one metric
     * and the average value of the metric in the last <period> seconds.
     * The average value is in the field 'value', the latest value is in the field 'lastValue'.
     * The Item's id is always null and the version 0.
     *
     */
    @Override
    public List<Item> getMeasurementResults(List<String> hostnames, List<String> metrics, String period) throws RemoteException {

        List<Item> items = new LinkedList<Item>();
        long currTime = System.currentTimeMillis()/1000;
        long startingTime = currTime - Long.parseLong(period); // that's the point of time where requested history starts

        synchronized (history) {
            LinkedList<State> historyImportant = new LinkedList<State>();  // the part of the history which lies in the period
            Iterator<State> iterator = history.descendingIterator();

            // get the latest history entry
            if (iterator.hasNext()) {
                State entry = iterator.next();
                historyImportant.add(entry);
                // check if the period is too long
                if (!iterator.hasNext() && entry.getTime() > startingTime)
                    throw new RemoteException("The period is too long for the existing history.");
            }

            while (iterator.hasNext()) {
                State entry = iterator.next();
                if (entry.getTime() < startingTime) {
                    break;
                }
                historyImportant.add(entry);
                if (!iterator.hasNext() && entry.getTime() > startingTime)
                    throw new RemoteException("The period is too long for the existing history.");
            }

            for (String host : hostnames) {
                // check if the host exists in the latest state of history
                if (!historyImportant.peekFirst().getHostsHistory().containsKey(host))
                    throw new RemoteException("The hostname " + host + " does not exist.");

                for (String metric : metrics) {
                    Iterator<State> historyIterator = historyImportant.iterator();

                    Item item = new Item();
                    item.setHostname(host);
                    item.setMetric(metric);

                    HistoryObject hObj = historyIterator.next().getHostsHistory().get(host);
                    if (!hObj.keyExists(metric))
                        throw new RemoteException("The metric " + metric + " does not exist for host " + host + ".");

                    item.setHostId(hObj.getHostId());

                    String value = hObj.getMeasurement(metric);
                    item.setLastValue(value);

                    Double avg = (Double) tryParse(value);
                    if (avg != null) { // it is a number and no string
                        while (historyIterator.hasNext()) {
                            Map<String, HistoryObject> hostsAndHistory = historyIterator.next().getHostsHistory();
                            if (!hostsAndHistory.containsKey(host)) {
                                throw new RemoteException("The period is too long for host " + host +
                                        " because he just started existing inside the specified time frame.");
                            }
                            if (!hostsAndHistory.get(host).keyExists(metric)) {
                                throw new RemoteException("The metric " + metric +
                                        "did not exist at every time in the specified period for host " + host + ".");
                            }
                            avg += Double.parseDouble(hostsAndHistory.get(host).getMeasurement(metric));
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
                HistoryObject ho = new HistoryObject();
                ho.setHostId(jsonObj.get("hostid").getAsString());
                // add the values to the HistoryObject
                while (itemIterator.hasNext()) {
                    JsonObject item = itemIterator.next().getAsJsonObject();
                    ho.setMeasurement(item.get("key_").getAsString(), item.get("lastvalue").getAsString());
                }

                snapshot.put(hostName, ho);
            }
            State state = new State(timestamp, snapshot);
            synchronized (history) {
                history.add(state);
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
        //log.debug("Response received: " + jsonResponse);

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

    private void init() throws RemoteException {
        zabbixIp = properties.getProperty("zabbix-ip");
        zabbixPort = properties.getProperty("zabbix-port");
        if (zabbixPort == null || zabbixPort.equals("")) {
            zabbixURL = "http://" + zabbixIp + "/zabbix/api_jsonrpc.php";
        }
        else {
            zabbixURL = "http://" + zabbixIp + ":" + zabbixPort + "/zabbix/api_jsonrpc.php";
        }
        username = properties.getProperty("user");
        password = properties.getProperty("password");
        type = properties.getProperty("type");
        requestFrequency = Integer.parseInt(properties.getProperty("client-request-frequency"));
        historyLength = Integer.parseInt(properties.getProperty("history-length"));
        history = new LimitedQueue<State>(historyLength);
        mapper = new GsonBuilder().setPrettyPrinting().create();
        try {
            authenticate(zabbixIp, username, password);
        } catch (MonitoringException e) {
            log.error("Authentication failed: " + e.getMessage());
            throw new RemoteException("Authentication to Zabbix server failed.");
        }

        updateHistory.run();
        scheduler.scheduleAtFixedRate(updateHistory, requestFrequency, requestFrequency, TimeUnit.SECONDS);


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

        //log.debug("Authenticated to Zabbix Server " + zabbixURL + " with TOKEN " + TOKEN);
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
    private void handleNotification(ZabbixNotification zabbixNotification) {
        //TODO create the standard notification, look for subscribers and invoke notifyResult

        notifyResults();
    }
    private void launchServer() throws IOException {
        server = HttpServer.create(new InetSocketAddress(8010), 1);
        myHandler=new MyHandler();
        server.createContext("/zabbixplugin/notifications", myHandler);
        log.debug("Notification receiver running on url: "+server.getAddress()+" port:"+server.getAddress().getPort());
        server.setExecutor(null);
        server.start();

    }
    class MyHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) throws IOException {
            InputStream is = t.getRequestBody();
            String message = read(is);
            checkRequest(message);
            String response = "";
            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }

        private void checkRequest(String message) {
            log.debug("\n\n");
            log.debug("Received: "+message);
            ZabbixNotification zabbixNotification;
            try {
                zabbixNotification = mapper.fromJson(message, ZabbixNotification.class);
            }catch (Exception e){
                log.warn("Impossible to retrive the ZabbixNotification received",e);
                return;
            }
            log.debug("\n");
            log.debug("ZabbixNotification: "+zabbixNotification);
            handleNotification(zabbixNotification);
        }
        private String read(InputStream is) throws IOException {

            BufferedReader streamReader = new BufferedReader(new InputStreamReader(is, "UTF-8"));

            StringBuilder responseStrBuilder = new StringBuilder();

            String inputStr;

            try
            {
                while ((inputStr = streamReader.readLine()) != null)
                    responseStrBuilder.append(inputStr);
            }
            catch (IOException e)
            {
                e.printStackTrace();
            }
            finally
            {
                streamReader.close();
            }
            return responseStrBuilder.toString();
        }


    }

}
