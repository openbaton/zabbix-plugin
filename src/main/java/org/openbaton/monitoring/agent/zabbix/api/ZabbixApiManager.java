package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.*;
import org.openbaton.monitoring.agent.ZabbixSender;
import org.openbaton.monitoring.agent.exceptions.MonitoringException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mob on 18.11.15.
 */
public class ZabbixApiManager {

    private Logger log = LoggerFactory.getLogger(this.getClass());
    private ZabbixSender zabbixSender;
    private Gson mapper=new GsonBuilder().setPrettyPrinting().create();

    public ZabbixApiManager(ZabbixSender zabbixSender){
        this.zabbixSender=zabbixSender;
    }

    public String createTrigger(String description,String expression) throws MonitoringException {
        log.debug("createTrigger");
        String triggerId=null;
        String params = "{'description':'"+description+"','expression':'"+expression+"'}";

        JsonObject responseObj = zabbixSender.callPost(params, "trigger.create");
        log.debug("response received:"+responseObj);
        JsonElement resultEl= responseObj.get("result");
        if(resultEl!=null && resultEl.isJsonObject()){
            JsonObject resultObj= resultEl.getAsJsonObject();
            triggerId= resultObj.get("triggerids").getAsJsonArray().get(0).getAsString();
            log.debug("Created trigger with id: "+triggerId);
        }
        return triggerId;
    }
    public List<String> deleteTriggers(List<String> triggersId) throws MonitoringException {
        List<String> triggerIdDeleted= new ArrayList<>();

        String params="[";
        String firstTriggerId=triggersId.get(0);
        for(String triggerId: triggersId){
            if(!triggerId.equals(firstTriggerId))
                params+=",";
            params+="\""+triggerId+"\"";
        }
        params+="]";
        JsonObject responseObj = zabbixSender.callPost(params, "trigger.delete");
        log.debug("response received:"+responseObj);
        JsonElement resultEl= responseObj.get("result");
        if(resultEl!=null && resultEl.isJsonObject()){
            JsonObject resultObj= resultEl.getAsJsonObject();
            JsonArray triggerIdsArray= resultObj.get("triggerids").getAsJsonArray();
            for (int i =0 ; i<triggerIdsArray.size(); i++){
                triggerIdDeleted.add(triggerIdsArray.get(i).getAsString());
            }

        }
        log.debug("Deleted the following trigger ids: "+triggerIdDeleted);
        return triggerIdDeleted;
    }
    public String createAction(String actionName,String triggerId) throws MonitoringException {
        log.debug("createAction");
        String actionId=null;
        ZabbixAction zabbixAction=new ZabbixAction();

        OpmessageUsr opmessageUsr=new OpmessageUsr();
        //Id of the admin user
        opmessageUsr.setUserId("1");

        Opmessage opmessage=new Opmessage();
        opmessage.setDefaultMsg(1);
        opmessage.setMediatypeid("4");

        Operation operation=new Operation();
        List<OpmessageUsr> opmessageUsrList= new ArrayList<>();
        opmessageUsrList.add(opmessageUsr);
        operation.setOpmessageUsr(opmessageUsrList);
        operation.setOperationtype(0);
        operation.setOpmessage(opmessage);

        Condition condition1= new Condition();
        condition1.setConditiontype(2);
        condition1.setOperator(0);
        //triggerId
        condition1.setValue(triggerId);

        Condition condition2= new Condition();
        condition2.setConditiontype(5);
        condition2.setOperator(0);
        condition2.setValue("1");

        zabbixAction.setName(actionName);
        List<Condition> conditions = new ArrayList<>(); conditions.add(condition1);conditions.add(condition2);
        zabbixAction.setConditions(conditions);

        String defLongData="{" +
                "\"triggerId\":\"{TRIGGER.ID}\"," +
                "\"triggerName\":\"{TRIGGER.NAME}\"," +
                "\"triggerStatus\": \"{TRIGGER.STATUS}\"," +
                "\"triggerSeverity\":\"{TRIGGER.SEVERITY}\"," +
                "\"triggerUrl\":\"{TRIGGER.URL}\"," +
                "\"itemName\":\"{ITEM.NAME}\"," +
                "\"hostName\":\"{HOST.NAME}\"," +
                "\"itemKey\":\"{ITEM.KEY}\"," +
                "\"itemValue\":\"{ITEM.VALUE}\"," +
                "\"eventId\":\"{EVENT.ID}\"," +
                "\"eventDate\":\"{EVENT.DATE}\"," +
                "\"eventTime\":\"{EVENT.TIME}\"" +
                "}";
        zabbixAction.setDefLongdata(defLongData);

        zabbixAction.setEscPeriod(60);
        zabbixAction.setEvaltype(1);
        zabbixAction.setEventsource(0);

        List<Operation> operations=new ArrayList<>();
        operations.add(operation);
        zabbixAction.setOperations(operations);

        String params = mapper.toJson(zabbixAction, ZabbixAction.class);

        log.debug("Sending params: "+params);

        JsonObject responseObj = zabbixSender.callPost(params, "action.create");
        log.debug("response received:"+responseObj);

        JsonElement resultEl= responseObj.get("result");
        if(resultEl!=null && resultEl.isJsonObject()){
            JsonObject resultObj= resultEl.getAsJsonObject();
            actionId= resultObj.get("actionids").getAsJsonArray().get(0).getAsString();
            log.debug("Created action with id: "+actionId);
        }
        return actionId;
    }

    // check parameter at url: https://www.zabbix.com/documentation/2.2/manual/api/reference/item/object
    public List<String> createItem(String name,Integer delay,String hostId,Integer type,Integer valuetype,String itemKey,String interfaceId) throws MonitoringException {
        List<String> itemsIds=new ArrayList<>();
        ZabbixItem item=new ZabbixItem(name,itemKey,hostId,type,valuetype,delay);
        item.setInterfaceId(interfaceId);
        String params= mapper.toJson(item,ZabbixItem.class);
        log.debug("Sending params (create item): "+params);

        JsonObject responseObj = zabbixSender.callPost(params, "item.create");
        log.debug("response received:"+responseObj);

        JsonElement resultEl= responseObj.get("result");
        if(resultEl!=null && resultEl.isJsonObject()){
            JsonObject resultObj= resultEl.getAsJsonObject();
            JsonArray itemsIdsArray= resultObj.get("itemids").getAsJsonArray();
            for (int i =0 ; i<itemsIdsArray.size(); i++){
                itemsIds.add(itemsIdsArray.get(i).getAsString());
            }
            log.debug("Created the following item ids: "+itemsIds);
        }
        return itemsIds;
    }
    public String getHostId(String hostname) throws MonitoringException {
        String hostId="";
        String params="{\"output\":[\"hostid\"],\"filter\":{\"host\":[\""+hostname+"\"]}}";
        log.debug("Sending params for getHostId: "+params);
        JsonObject responseObj = zabbixSender.callPost(params, "host.get");
        log.debug("response received:"+responseObj);

        JsonElement resultEl= responseObj.get("result");
        if(resultEl!=null && resultEl.isJsonArray()){
            JsonArray resultAr= resultEl.getAsJsonArray();
            hostId = resultAr.get(0).getAsJsonObject().get("hostid").getAsString();
            log.debug("The host id of "+hostname+" is : "+hostId);
        }
        return hostId;
    }

    public String getHostInterfaceId(String hostID) throws MonitoringException {
        String interfaceId=null;
        String params="{\"output\":\"extend\",\"hostids\":\""+hostID+"\"}";
        log.debug("Sending params for HostInterfaceId: "+params);
        JsonObject responseObj = zabbixSender.callPost(params, "hostinterface.get");
        log.debug("response received:"+responseObj);

        JsonElement resultEl= responseObj.get("result");
        if(resultEl!=null && resultEl.isJsonArray()){
            JsonArray resultAr= resultEl.getAsJsonArray();
            for (int i =0 ; i<resultAr.size(); i++){
                JsonObject interfaceInfoObj= resultAr.get(i).getAsJsonObject();
                if(interfaceInfoObj.get("type").getAsString().equals("1")
                        && interfaceInfoObj.get("port").getAsString().equals("10050")
                        && interfaceInfoObj.get("ip").getAsString().startsWith("192"))
                    interfaceId=interfaceInfoObj.get("interfaceid").getAsString();
            }
        }
        log.debug("The interface id is:"+interfaceId);
        return interfaceId;
    }
}
