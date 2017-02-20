/*
 * Copyright (c) 2015-2016 Fraunhofer FOKUS
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.*;
import java.util.ArrayList;
import java.util.List;
import org.openbaton.exceptions.MonitoringException;
import org.openbaton.monitoring.agent.ZabbixSender;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/** Created by mob on 18.11.15. */
public class ZabbixApiManager {

  private Logger log = LoggerFactory.getLogger(this.getClass());
  private ZabbixSender zabbixSender;
  private Gson mapper = new GsonBuilder().setPrettyPrinting().create();
  private String zabbixServerVersion;

  public ZabbixApiManager(ZabbixSender zabbixSender, String zabbixServerVersion) {
    this.zabbixSender = zabbixSender;
    this.zabbixServerVersion = zabbixServerVersion;
  }

  public void destroy() {
    zabbixSender.destroy();
  }

  public String createTrigger(String description, String expression, Integer priority)
      throws MonitoringException {
    log.debug("createTrigger");
    String triggerId = null;
    String params =
        "{'description':'"
            + description
            + "','expression':'"
            + expression
            + "', 'priority':'"
            + priority
            + "'}";

    JsonObject responseObj = zabbixSender.callPost(params, "trigger.create");
    log.debug("response received:" + responseObj);
    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      triggerId = resultObj.get("triggerids").getAsJsonArray().get(0).getAsString();
      log.debug("Created trigger with id: " + triggerId);
    }
    return triggerId;
  }

  public String createPrototypeTrigger(String description, String expression, Integer priority)
      throws MonitoringException {
    log.debug("createPrototypeTrigger");
    String prototypeTriggerId = null;
    String params =
        "{'description':'"
            + description
            + "','expression':'"
            + expression
            + "', 'priority':'"
            + priority
            + "'}";

    JsonObject responseObj = zabbixSender.callPost(params, "triggerprototype.create");
    log.debug("response received (createPrototypeTrigger):" + responseObj);
    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      prototypeTriggerId = resultObj.get("triggerids").getAsJsonArray().get(0).getAsString();
      log.debug("Created prototypetrigger with id: " + prototypeTriggerId);
    }
    return prototypeTriggerId;
  }

  public List<String> delete(String object, List<String> idsToDelete) throws MonitoringException {
    List<String> objectIdDeleted = new ArrayList<>();
    String params = "[";
    String firstObjectId = idsToDelete.get(0);
    for (String triggerId : idsToDelete) {
      if (!triggerId.equals(firstObjectId)) params += ",";
      params += "\"" + triggerId + "\"";
    }
    params += "]";
    JsonObject responseObj = zabbixSender.callPost(params, object + ".delete");
    log.debug("Response received for " + object + ".delete :" + responseObj);
    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      JsonArray objectIdsArray;
      if (object.equals("itemprototype")) {
        objectIdsArray = resultObj.get("prototypeids").getAsJsonArray();
      } else if (object.equals("triggerprototype")) {
        objectIdsArray = resultObj.get("triggerids").getAsJsonArray();
      } else objectIdsArray = resultObj.get(object + "ids").getAsJsonArray();
      for (int i = 0; i < objectIdsArray.size(); i++) {
        objectIdDeleted.add(objectIdsArray.get(i).getAsString());
      }
    }
    log.debug("Deleted the following " + object + "ids: " + objectIdDeleted);
    return objectIdDeleted;
  }

  public List<String> deleteTriggers(List<String> triggersIds) throws MonitoringException {
    return delete("trigger", triggersIds);
  }

  public List<String> deleteTriggerPrototype(List<String> triggersIds) throws MonitoringException {
    return delete("triggerprototype", triggersIds);
  }

  public List<String> deleteItems(List<String> itemIdsToDelete) throws MonitoringException {
    return delete("item", itemIdsToDelete);
  }

  public List<String> deletePrototypeItems(List<String> itemIdsToDelete)
      throws MonitoringException {
    return delete("itemprototype", itemIdsToDelete);
  }

  public List<String> deleteActions(List<String> actionIdsToDelete) throws MonitoringException {
    return delete("action", actionIdsToDelete);
  }

  public String createAction(String actionName, String triggerName, String mediatypeId)
      throws MonitoringException {
    log.debug("createAction");
    String actionId = null;
    ZabbixAction zabbixAction;
    if (zabbixServerVersion.startsWith("3")) zabbixAction = new ZabbixAction_v30();
    else zabbixAction = new ZabbixAction_v22();

    OpmessageUsr opmessageUsr = new OpmessageUsr();
    //Id of the admin user
    opmessageUsr.setUserId("1");

    Opmessage opmessage = new Opmessage();
    opmessage.setDefaultMsg(1);
    //MediaType script
    opmessage.setMediatypeid(mediatypeId);

    Operation operation = new Operation();
    List<OpmessageUsr> opmessageUsrList = new ArrayList<>();
    opmessageUsrList.add(opmessageUsr);
    operation.setOpmessageUsr(opmessageUsrList);
    operation.setOperationtype(0);
    operation.setOpmessage(opmessage);

    List<Condition> conditions = new ArrayList<>();

    Condition condition1 = new Condition();
    condition1.setConditiontype(3);
    condition1.setOperator(2);
    //triggerId
    condition1.setValue(triggerName);
    conditions.add(condition1);

    //If commented we get notification also if the trigger switch from PROBLEM to OK
    /*
    Condition condition2= new Condition();
    condition2.setConditiontype(5);
    condition2.setOperator(0);
    condition2.setValue("1");
    conditions.add(condition2);
    */

    zabbixAction.setName(actionName);

    zabbixAction.setConditions(conditions);

    String defLongData;
    if (zabbixServerVersion.startsWith("3"))
      defLongData =
          "{"
              + "triggerId: \"{TRIGGER.ID}\", "
              + "triggerName: \"{TRIGGER.NAME}\", "
              + "triggerStatus: {TRIGGER.STATUS}, "
              + "triggerSeverity: \"{TRIGGER.SEVERITY}\", "
              + "triggerUrl: \"{TRIGGER.URL}\", "
              + "itemName: \"{ITEM.NAME}\", "
              + "hostName: \"{HOST.NAME}\", "
              + "itemKey: \"{ITEM.KEY}\", "
              + "itemValue: \"{ITEM.VALUE}\", "
              + "eventId: {EVENT.ID}, "
              + "eventDate: \"{EVENT.DATE}\", "
              + "eventTime: \"{EVENT.TIME}\""
              + "}";
    else
      defLongData =
          "{"
              + "triggerId: {TRIGGER.ID}, "
              + "triggerName: {TRIGGER.NAME}, "
              + "triggerStatus: {TRIGGER.STATUS}, "
              + "triggerSeverity: {TRIGGER.SEVERITY}, "
              + "triggerUrl: {TRIGGER.URL}, "
              + "itemName: {ITEM.NAME}, "
              + "hostName: {HOST.NAME}, "
              + "itemKey: {ITEM.KEY}, "
              + "itemValue: {ITEM.VALUE}, "
              + "eventId: {EVENT.ID}, "
              + "eventDate: {EVENT.DATE}, "
              + "eventTime: {EVENT.TIME}"
              + "}";
    zabbixAction.setDefLongdata(defLongData);

    zabbixAction.setEscPeriod(60);
    zabbixAction.setEvaltype(1);
    zabbixAction.setEventsource(0);

    List<Operation> operations = new ArrayList<>();
    operations.add(operation);
    zabbixAction.setOperations(operations);
    String params;
    if (zabbixServerVersion.startsWith("3"))
      params = mapper.toJson(zabbixAction, ZabbixAction_v30.class);
    else params = mapper.toJson(zabbixAction, ZabbixAction_v22.class);

    log.debug("Sending params: " + params);

    JsonObject responseObj = zabbixSender.callPost(params, "action.create");
    log.debug("response received for creating action:" + responseObj);

    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      actionId = resultObj.get("actionids").getAsJsonArray().get(0).getAsString();
      log.debug("Created action with id: " + actionId);
    }
    return actionId;
  }

  // check parameter at url: https://www.zabbix.com/documentation/2.2/manual/api/reference/item/object
  public String createItem(
      String name,
      Integer delay,
      String hostId,
      Integer type,
      Integer valuetype,
      String itemKey,
      String interfaceId)
      throws MonitoringException {
    String itemsId;
    ZabbixItem item = new ZabbixItem(name, itemKey, hostId, type, valuetype, delay);
    item.setInterfaceId(interfaceId);
    String params = mapper.toJson(item, ZabbixItem.class);
    log.debug("Sending params (create item): " + params);

    JsonObject responseObj = zabbixSender.callPost(params, "item.create");
    log.debug("response received:" + responseObj);

    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      JsonArray itemsIdsArray = resultObj.get("itemids").getAsJsonArray();
      itemsId = itemsIdsArray.get(0).getAsString();
      log.debug("Created the following item ids: " + itemsId);
    } else throw new MonitoringException("Unknown response from zabbix server: " + responseObj);

    return itemsId;
  }

  public String getItemId(String itemKey, String hostId) throws MonitoringException {
    String itemId = null;

    String params =
        "{'output': ['itemid'],'hostids': '" + hostId + "','search': {'key_': '" + itemKey + "'}}";
    log.debug("Sending params (get item): " + params);

    JsonObject responseObj = zabbixSender.callPost(params, "item.get");
    log.debug("response received:" + responseObj);

    JsonElement resultEl = responseObj.get("result");

    if (resultEl == null || !resultEl.isJsonArray())
      throw new MonitoringException("Unknown response from zabbix server: " + responseObj);

    JsonArray resultArray = resultEl.getAsJsonArray();
    if (resultArray.size() != 0) {
      JsonObject itemIdObj = resultArray.get(0).getAsJsonObject();
      itemId = itemIdObj.get("itemid").getAsString();
      log.debug("The item with itemKey " + itemKey + " has the id: " + itemId);
    } else log.debug("The item with itemKey " + itemKey + " does not exists");
    return itemId;
  }

  public String getScriptUserMediaScript() throws MonitoringException {
    String params = "{\"output\":\"extend\"}";
    JsonObject responseObj = zabbixSender.callPost(params, "usermedia.get");
    try {
      JsonElement resultEl = responseObj.get("result");
      if (resultEl != null && resultEl.isJsonArray()) {
        JsonArray resultAr = resultEl.getAsJsonArray();
        for (JsonElement elementOfArray : resultAr) {
          JsonObject resultObjectMap = elementOfArray.getAsJsonObject();
          if (resultObjectMap.get("sendto") == null) continue;
          String sendto = resultObjectMap.get("sendto").getAsString();
          if (sendto.contains("zabbixplugin")) return resultObjectMap.get("mediaid").getAsString();
        }
      }
    } catch (Exception e) {
      return null;
    }
    return null;
  }

  public String getMediaTypeId(String mediaId) throws MonitoringException {
    String mediatypeId = null;
    String params = "{\"output\":[\"mediatypeid\"],\"mediaids\":\"" + mediaId + "\"}";
    JsonObject responseObj = zabbixSender.callPost(params, "mediatype.get");
    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonArray()) {
      JsonArray resultAr = resultEl.getAsJsonArray();
      JsonObject resultObjectMap = resultAr.get(0).getAsJsonObject();
      mediatypeId = resultObjectMap.get("mediatypeid").getAsString();
    }
    return mediatypeId;
  }

  public String addMedia(String userId, String mediatypeId, String zabbixPluginIp)
      throws MonitoringException {
    String mediaId = null;
    String params =
        "{'users': [{'userid':'"
            + userId
            + "'}],'medias':{'mediatypeid':'"
            + mediatypeId
            + "',"
            + "'sendto':'"
            + zabbixPluginIp
            + ":8010/zabbixplugin/notifications',"
            + "'active':0,\"period\": \"1-7,00:00-24:00\",\"severity\":63} }";
    JsonObject responseObj = zabbixSender.callPost(params, "user.addmedia");
    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      JsonArray itemsIdsArray = resultObj.get("mediaids").getAsJsonArray();
      mediaId = itemsIdsArray.get(0).getAsString();
    }
    return mediaId;
  }

  public String createMediaTypeScript() throws MonitoringException {
    String mediatypeId = null;
    String params =
        "{\"description\":\"Script\",\"type\":1,\"exec_path\":\"send_notification.sh\","
            + "\"exec_params\":\"{ALERT.SENDTO}\n{ALERT.SUBJECT}\n{ALERT.MESSAGE}\n\"}";

    JsonObject responseObj = zabbixSender.callPost(params, "mediatype.create");
    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      JsonArray mediatypeIdsArray = resultObj.get("mediatypeids").getAsJsonArray();
      mediatypeId = mediatypeIdsArray.get(0).getAsString();
      log.debug("Created the mediatype script with id: " + mediatypeId);
    }

    return mediatypeId;
  }

  public String getHostId(String hostname) throws MonitoringException {
    String hostId = "";
    String params = "{'output': ['hostid'],'filter':{'host': ['" + hostname + "']}}";
    log.debug("Sending params for getHostId: " + params);
    JsonObject responseObj = zabbixSender.callPost(params, "host.get");
    log.debug("response received:" + responseObj);

    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonArray()) {
      JsonArray resultAr = resultEl.getAsJsonArray();
      if (resultAr.size() == 0)
        throw new MonitoringException("No host found with name: " + hostname);
      JsonObject resultObjectMap = resultAr.get(0).getAsJsonObject();
      hostId = resultObjectMap.get("hostid").getAsString();
      log.debug("The host id of " + hostname + " is : " + hostId);
    }
    return hostId;
  }

  public String createPrototypeItem(
      Integer delay,
      String hostId,
      String interfaceId,
      String key_,
      String name,
      Integer type,
      Integer value_type,
      String ruleId)
      throws MonitoringException {
    String prototypeItemsId;
    ZabbixPrototypeItem prototypeItem =
        new ZabbixPrototypeItem(name, key_, hostId, type, value_type, delay);
    prototypeItem.setInterfaceId(interfaceId);
    prototypeItem.setRuleId(ruleId);

    String params = mapper.toJson(prototypeItem, ZabbixPrototypeItem.class);
    log.debug("Sending params (create prototype item): " + params);

    JsonObject responseObj = zabbixSender.callPost(params, "itemprototype.create");
    log.debug("response received:" + responseObj);

    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonObject()) {
      JsonObject resultObj = resultEl.getAsJsonObject();
      JsonArray itemsIdsArray = resultObj.get("itemids").getAsJsonArray();
      prototypeItemsId = itemsIdsArray.get(0).getAsString();
      log.debug("Created the following prototype item ids: " + prototypeItemsId);
    } else throw new MonitoringException("Unknown response from zabbix server: " + responseObj);

    return prototypeItemsId;
  }

  public String getHostInterfaceId(String hostID) throws MonitoringException {
    String interfaceId = null;
    String params = "{\"output\":\"extend\",\"hostids\":\"" + hostID + "\"}";
    log.debug("Sending params for HostInterfaceId: " + params);
    JsonObject responseObj = zabbixSender.callPost(params, "hostinterface.get");
    log.debug("response received:" + responseObj);

    JsonElement resultEl = responseObj.get("result");
    if (resultEl != null && resultEl.isJsonArray()) {
      JsonArray resultAr = resultEl.getAsJsonArray();
      for (int i = 0; i < resultAr.size(); i++) {
        JsonObject interfaceInfoObj = resultAr.get(i).getAsJsonObject();
        if (interfaceInfoObj.get("type").getAsString().equals("1")
            && interfaceInfoObj.get("port").getAsString().equals("10050")
            && interfaceInfoObj.get("ip").getAsString().startsWith("192"))
          interfaceId = interfaceInfoObj.get("interfaceid").getAsString();
      }
    }
    log.debug("The interface id is:" + interfaceId);
    return interfaceId;
  }

  public String getPrototypeTriggerId(String ruleId) throws MonitoringException {
    String params =
        "{\n"
            + "        'output': 'extend',\n"
            + "        'discoveryids': '"
            + ruleId
            + "'\n"
            + "    }";
    JsonObject responseObj = zabbixSender.callPost(params, "triggerprototype.get");
    JsonElement resultEl = responseObj.get("result");
    log.debug("Received result: " + resultEl.toString());
    if (resultEl != null && resultEl.isJsonArray()) {
      JsonArray resultAr = resultEl.getAsJsonArray();

      JsonObject ruleObj = resultAr.get(0).getAsJsonObject();
      ruleId = ruleObj.get("triggerid").getAsString();
    }
    return ruleId;
  }

  public String getRuleId(String hostId) throws MonitoringException {
    String ruleId = "";
    String params = "{'output':'extend','hostids':'" + hostId + "'}";
    log.debug("Sending param: " + params);
    JsonObject responseObj = zabbixSender.callPost(params, "discoveryrule.get");
    JsonElement resultEl = responseObj.get("result");
    log.debug("Received result: " + resultEl.toString());
    if (resultEl != null && resultEl.isJsonArray()) {
      JsonArray resultAr = resultEl.getAsJsonArray();

      JsonObject ruleObj = resultAr.get(0).getAsJsonObject();
      ruleId = ruleObj.get("itemid").getAsString();
    }
    return ruleId;
  }
}
