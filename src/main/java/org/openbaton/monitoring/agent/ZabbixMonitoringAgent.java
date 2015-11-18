package org.openbaton.monitoring.agent;


import com.google.gson.*;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import org.openbaton.catalogue.nfvo.EndpointType;
import org.openbaton.catalogue.nfvo.Item;
import org.openbaton.monitoring.agent.alarm.catalogue.*;
import org.openbaton.monitoring.agent.exceptions.MonitoringException;
import org.openbaton.monitoring.agent.interfaces.VirtualisedResourceFaultManagement;
import org.openbaton.monitoring.agent.interfaces.VirtualisedResourcesPerformanceManagement;
import org.openbaton.monitoring.agent.performance.management.catalogue.ResourceSelector;
import org.openbaton.monitoring.agent.performance.management.catalogue.ThresholdDetails;
import org.openbaton.monitoring.agent.zabbix.api.*;
import org.openbaton.monitoring.interfaces.MonitoringPlugin;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.net.InetSocketAddress;
import java.rmi.RemoteException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import static com.google.common.primitives.Doubles.tryParse;

/**
 * Created by mob on 22.10.15.
 */
public class ZabbixMonitoringAgent extends MonitoringPlugin implements VirtualisedResourceFaultManagement,VirtualisedResourcesPerformanceManagement {

    private int historyLength;
    private int requestFrequency;
    private ZabbixSender zabbixSender;
    private ZabbixApiManager zabbixApiManager;
    private String notificationReceiverServerContext;
    private int notificationReceiverServerPort;
    private Gson mapper;
    protected Logger log = LoggerFactory.getLogger(this.getClass());
    private List<AlarmEndpoint> subscriptions;
    private String type;
    private Map<String, List<String>> triggerIdHostnames;
    private LimitedQueue<State> history;
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);

    //Server properties
    private HttpServer server;
    private MyHandler myHandler;
    //

    public ZabbixMonitoringAgent() throws RemoteException {
        init();
        try {
            launchServer(notificationReceiverServerPort,notificationReceiverServerContext);
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
                responseObj = zabbixSender.callPost(params, "host.get");
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

    private void init() throws RemoteException {
        String zabbixIp = properties.getProperty("zabbix-ip");
        String zabbixPort = properties.getProperty("zabbix-port");
        String username = properties.getProperty("user");
        String password = properties.getProperty("password");
        zabbixSender = new ZabbixSender(zabbixIp,zabbixPort,username,password);
        zabbixApiManager= new ZabbixApiManager(zabbixSender);
        String nrsp=properties.getProperty("notification-receiver-server-port","8010");
        notificationReceiverServerPort=Integer.parseInt(nrsp);

        notificationReceiverServerContext = properties.getProperty("notification-receiver-server-context","/zabbixplugin/notifications");

        type = properties.getProperty("type");
        requestFrequency = Integer.parseInt(properties.getProperty("client-request-frequency"));
        historyLength = Integer.parseInt(properties.getProperty("history-length"));
        history = new LimitedQueue<>(historyLength);
        mapper = new GsonBuilder().setPrettyPrinting().create();
        subscriptions=new ArrayList<>();
        subscriptions.add(new AlarmEndpoint("fmsystem",null, EndpointType.REST,"localhost:9000/alarm/vr",PerceivedSeverity.MAJOR));
        triggerIdHostnames=new HashMap<>();

        try {
            zabbixSender.authenticate();
        } catch (MonitoringException e) {
            log.error("Authentication failed: " + e.getMessage());
            throw new RemoteException("Authentication to Zabbix server failed.");
        }

        updateHistory.run();
        scheduler.scheduleAtFixedRate(updateHistory, requestFrequency, requestFrequency, TimeUnit.SECONDS);

        //String triggerId=createTrigger("Trigger on demand", "{Template OS Linux:system.cpu.load[percpu,avg1].last(0)}>0.6");
        //zabbixApiManager.createAction("ZabbixAction on demand", "19961");
    }
    /**
     * terminate the scheduler safely
     */
    public void terminate() {
        shutdownAndAwaitTermination(scheduler);
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

        //Check if the trigger is crossed for the first time
        if(isNewNotification(zabbixNotification)) {
            //TODO create Threshold crossed notification
            //if the severity of the notification is more than Not classified or Information,
            // create an alarm or change the state of an existing alarm
            if (!(zabbixNotification.getTriggerSeverity().equals("Not classified") || zabbixNotification.getTriggerSeverity().equals("Information"))) {

                Alarm alarm = createAlarm(zabbixNotification);
                AbstractVirtualizedResourceAlarm notification = new VirtualizedResourceAlarmNotification(alarm.getTriggerId(), alarm);

                sendNotification(notification);

            }
            List<String> hostnames= new ArrayList<>();
            hostnames.add(zabbixNotification.getHostName());
            triggerIdHostnames.put(zabbixNotification.getTriggerId(),hostnames);
            log.debug("triggerIdHostnames: "+triggerIdHostnames);
        }
        else {
            //TODO create Threshold crossed notification
            if (!(zabbixNotification.getTriggerSeverity().equals("Not classified") || zabbixNotification.getTriggerSeverity().equals("Information"))) {

                AlarmState alarmState= zabbixNotification.getTriggerStatus() == TriggerStatus.OK ? AlarmState.CLEARED : AlarmState.UPDATED;
                AbstractVirtualizedResourceAlarm notification = new VirtualizedResourceAlarmStateChangedNotification(zabbixNotification.getTriggerId(),alarmState);

                sendNotification(notification);
            }
        }
    }
    private boolean isNewNotification(ZabbixNotification zabbixNotification){
        if(triggerIdHostnames.get(zabbixNotification.getTriggerId())==null)
            return true;
        if(!(triggerIdHostnames.get(zabbixNotification.getTriggerId()).contains(zabbixNotification.getHostName())))
            return true;
        return false;
    }
    private void sendNotification(AbstractVirtualizedResourceAlarm notification) {
        //TODO send only to subscribers with certain PerceivedSeverity and resourceId specified

        for(AlarmEndpoint ae: subscriptions){

            try {
                notifyFault(ae, notification);
            } catch (UnirestException e) {
                log.error(e.getMessage(),e);
            }
        }

    }

    private Alarm createAlarm(ZabbixNotification zabbixNotification) {
        Alarm alarm= new Alarm();

        alarm.setTriggerId(zabbixNotification.getTriggerId());

        //AlarmRaisedTime: It indicates the date and time when the alarm is first raised by the managed object. 
        alarm.setAlarmRaisedTime(zabbixNotification.getEventDate()+" "+zabbixNotification.getEventTime());

        //EventTime: Time when the fault was observed. 
        DateFormat dateFormat= new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
        alarm.setEventTime(dateFormat.format(date));

        //AlarmState: State of the alarm, e.g. “fired”, “updated”, “cleared”. 
        alarm.setAlarmState(AlarmState.FIRED);

        /*
        Type of the fault.The allowed values for the faultyType attribute depend
        on the type of the related managed object. For example, a resource of type “compute”
        may have faults of type “CPU failure”, “memory failure”, “network card failure”, etc. 
        */
        alarm.setFaultType(getFaultType(zabbixNotification.getItemKey()));

        /*
        Identifier of the affected managed Object. The Managed Objects for this information element
        will be virtualised resources. These resources shall be known by the Virtualised Resource Management interface. 
        */
        alarm.setResourceId(zabbixNotification.getHostName());

        //Perceived severity of the managed object failure
        alarm.setPerceivedSeverity(getPerceivedSeverity(zabbixNotification.getTriggerSeverity()));

        return alarm;
    }

    private PerceivedSeverity getPerceivedSeverity(String triggerSeverity) {
        switch (triggerSeverity){
            case "Not classified": return PerceivedSeverity.INDETERMINATE;
            case "Information": return PerceivedSeverity.WARNING;
            case "Warning": return PerceivedSeverity.WARNING;
            case "Average": return PerceivedSeverity.MINOR;
            case "High":  return PerceivedSeverity.MAJOR;
            case "Disaster": return PerceivedSeverity.CRITICAL;
        }
        return null;
    }

    private FaultType getFaultType(String itemKey) {
        Metric metric;
        int index= itemKey.indexOf('[');
        if(index!=-1)
            metric=getMetric(itemKey.substring(0, index));
        else metric=getMetric(itemKey);


        switch (metric){
            case SYSTEM_CPU_LOAD: return FaultType.COMPUTE_HOGS_CPU;
        }
        return null;
    }

    private Metric getMetric(String substring) {
        switch (substring){
            case "system.cpu.load": return Metric.SYSTEM_CPU_LOAD;
        }
        return null;
    }


    private void launchServer(int port, String context) throws IOException {
        server = HttpServer.create(new InetSocketAddress(port), 1);
        myHandler=new MyHandler();
        server.createContext(context, myHandler);
        log.debug("Notification receiver server running on url: "+server.getAddress()+" port:"+server.getAddress().getPort());
        server.setExecutor(null);
        server.start();
    }

    @Override
    public String subscribe(AlarmEndpoint endpoint) {
        return null;
    }

    @Override
    public void unsubscribe(String alarmEndpointId) {

    }

    @Override
    public void notifyFault(AlarmEndpoint endpoint, AbstractVirtualizedResourceAlarm event) throws UnirestException {
        HttpResponse<String> response = null;
        if(event instanceof VirtualizedResourceAlarmNotification){
            VirtualizedResourceAlarmNotification vran = (VirtualizedResourceAlarmNotification) event;
            String jsonAlarm = mapper.toJson(vran,VirtualizedResourceAlarmNotification.class);
            log.debug("Sending VirtualizedResourceAlarmNotification: "+jsonAlarm +" to: "+endpoint);
            response = Unirest.post(endpoint.getEndpoint()).header("Content-type","application/json").body(jsonAlarm).asString();

        }
        else if (event instanceof VirtualizedResourceAlarmStateChangedNotification){
            VirtualizedResourceAlarmStateChangedNotification vrascn= (VirtualizedResourceAlarmStateChangedNotification) event;
            String jsonAlarm = mapper.toJson(vrascn,VirtualizedResourceAlarmStateChangedNotification.class);
            log.debug("Sending VirtualizedResourceAlarmStateChangedNotification: "+jsonAlarm+" to: "+endpoint);
            response = Unirest.put(endpoint.getEndpoint()).header("Content-type","application/json").body(jsonAlarm).asString();
        }

    }

    @Override
    public List<Alarm> getAlarmList(String vnfId, PerceivedSeverity perceivedSeverity) {
        return null;
    }

    @Override
    public void createPMJob() {

    }

    @Override
    public void deletePMJob() {

    }

    @Override
    public void queryPMJob() {

    }

    @Override
    public void subscribe() {

    }

    @Override
    public void notifyInfo() {

    }

    @Override
    public String createThreshold(ResourceSelector resourceSelector, String performanceMetric, String thresholdType, ThresholdDetails thresholdDetails) throws MonitoringException {

        List<String> hostnames= resourceSelector.getHostnames();
        String firstHostname= hostnames.get(0);
        String thresholdExpression="";
        for(String hostname: hostnames){
            String singleHostExpression="";
            if(!hostname.equals(firstHostname))
                singleHostExpression+=thresholdType;
            singleHostExpression+="{"+hostname+":"+performanceMetric;
            if(thresholdDetails.getFunction() != null && !thresholdDetails.getFunction().isEmpty())
                singleHostExpression+="."+thresholdDetails.getFunction();
            singleHostExpression+="}"+thresholdDetails.getTriggerOperator()+thresholdDetails.getValue();
            thresholdExpression+=singleHostExpression;
        }

        String triggerId = zabbixApiManager.createTrigger("Threshold1",thresholdExpression);

        return triggerId;
    }

    @Override
    public List<String> deleteThreshold(List<String> thresholdIds) throws MonitoringException {
        return zabbixApiManager.deleteTriggers(thresholdIds);
    }

    @Override
    public void queryThreshold(String queryFilter) {

    }

    class MyHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange t) {
            InputStream is = t.getRequestBody();

            String message = read(is);
            checkRequest(message);
            String response = "";
            try {
                t.sendResponseHeaders(200, response.length());
                OutputStream os = t.getResponseBody();
                os.write(response.getBytes());
                os.close();
            }catch (IOException e){
                log.error(e.getMessage(),e);
            }
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
        private String read(InputStream is){

            StringBuilder responseStrBuilder = new StringBuilder();

            String inputStr;

            try (BufferedReader streamReader = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {
                while ((inputStr = streamReader.readLine()) != null)
                    responseStrBuilder.append(inputStr);
            } catch (IOException e) {
               log.error(e.getMessage(),e);
            }
            return responseStrBuilder.toString();
        }


    }

}
