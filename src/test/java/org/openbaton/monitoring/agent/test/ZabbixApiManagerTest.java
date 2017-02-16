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

package org.openbaton.monitoring.agent.test;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Properties;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.openbaton.exceptions.MonitoringException;
import org.openbaton.monitoring.agent.ZabbixSender;
import org.openbaton.monitoring.agent.zabbix.api.ZabbixApiManager;

/** Created by mob on 25.11.15. */
public class ZabbixApiManagerTest {

  private final List<String> hostnameList = Collections.singletonList("Zabbix server");
  private static ZabbixApiManager zabbixApiManager;
  private static List<String> triggerIds, actionIds, prototypeIds;
  private static Properties properties;
  @Rule public ExpectedException thrown = ExpectedException.none();

  @BeforeClass
  public static void init() throws IOException, MonitoringException {
    properties = new Properties();
    properties.load(ZabbixApiManagerTest.class.getResourceAsStream("/plugin.conf.properties"));
    if (properties.getProperty("external-properties-file") != null) {
      File externalPropertiesFile = new File(properties.getProperty("external-properties-file"));
      if (externalPropertiesFile.exists()) {
        InputStream is = new FileInputStream(externalPropertiesFile);
        properties.load(is);
      }
    }
    ZabbixSender zabbixSender =
        new ZabbixSender(
            properties.getProperty("zabbix-host"),
            properties.getProperty("zabbix-port"),
            Boolean.parseBoolean(properties.getProperty("zabbix-ssl", "false")),
            properties.getProperty("user-zbx"),
            properties.getProperty("password-zbx"));
    zabbixSender.authenticate(
        "http://" + properties.getProperty("zabbix-host") + "/zabbix/api_jsonrpc.php",
        properties.getProperty("user-zbx"),
        properties.getProperty("password-zbx")); /* to force double authentication */
    zabbixApiManager =
        new ZabbixApiManager(zabbixSender, properties.getProperty("zabbix-server-version", "3.0"));
    triggerIds = new ArrayList<>();
    actionIds = new ArrayList<>();
    prototypeIds = new ArrayList<>();
  }

  @Test
  public void edgeCasesForInitTest() throws MonitoringException {
    thrown.expect(MonitoringException.class);
    thrown.expectMessage("Invalid params. Login name or password is incorrect.");

    ZabbixSender zabbixSender =
        new ZabbixSender(
            properties.getProperty("zabbix-host"),
            "80" /* explicit port-string */,
            false,
            properties.getProperty("user-zbx"),
            properties.getProperty("Wrong Password"));
    zabbixSender.authenticate();
  }

  @Test
  public void createActionAndTriggerTest() throws MonitoringException {
    for (String host : hostnameList) {
      String hostId = zabbixApiManager.getHostId(host);
      String triggerId =
          zabbixApiManager.createTrigger(
              "Test trigger for " + host,
              "{" + host + ":system.cpu.load[percpu,avg1].last(0)}>0.45",
              3);
      triggerIds.add(triggerId);
      String actionId = zabbixApiManager.createAction("Test action for " + host, triggerId);
      actionIds.add(actionId);
    }
  }

  @Test
  public void hostNoHostFoundTest() throws MonitoringException {
    thrown.expect(MonitoringException.class);
    thrown.expectMessage("No host found with name: ");

    String hostId = zabbixApiManager.getHostId("non-existend");
  }

  @Test
  public void actionAlreadyExistsTest() throws MonitoringException {
    thrown.expect(MonitoringException.class);
    thrown.expectMessage("Action \"Test action\" already exists");

    String actionId = zabbixApiManager.createAction("Test action", "non-exitend");
    actionIds.add(actionId);
    actionId = zabbixApiManager.createAction("Test action", "non-exitend");
  }

  @Test
  public void triggerIncorrectExpressionTest() throws MonitoringException {
    thrown.expect(MonitoringException.class);
    thrown.expectMessage(
        "Invalid params. Incorrect trigger expression. "
            + "Check expression part starting from \"{}\".");

    String triggerId = zabbixApiManager.createTrigger("Test trigger", "{}", 3);
    triggerIds.add(triggerId);
  }

  @Test
  public void prototypeTest() throws MonitoringException {
    String hostId = zabbixApiManager.getHostId(hostnameList.get(0));
    String interfaceId = zabbixApiManager.getHostInterfaceId(hostId);
    String ruleId = zabbixApiManager.getRuleId(hostId);
    String prototypeId =
        zabbixApiManager.createPrototypeItem(
            5, hostId, interfaceId, "tcp.listen.port[5010]", "ping prototyp", 0, 0, ruleId);
    prototypeIds.add(prototypeId);
  }

  @AfterClass
  public static void destroy() throws MonitoringException {
    if (!actionIds.isEmpty()) {
      zabbixApiManager.deleteActions(actionIds);
    }
    if (!triggerIds.isEmpty()) {
      zabbixApiManager.deleteTriggers(triggerIds);
    }
    if (!prototypeIds.isEmpty()) {
      zabbixApiManager.deletePrototypeItems(prototypeIds);
    }
  }
}
