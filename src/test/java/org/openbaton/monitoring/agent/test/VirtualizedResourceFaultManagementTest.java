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

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openbaton.catalogue.mano.common.faultmanagement.VirtualizedResourceAlarmNotification;
import org.openbaton.catalogue.mano.common.monitoring.AbstractVirtualizedResourceAlarm;
import org.openbaton.catalogue.mano.common.monitoring.AlarmEndpoint;
import org.openbaton.catalogue.mano.common.monitoring.ObjectSelection;
import org.openbaton.catalogue.mano.common.monitoring.PerceivedSeverity;
import org.openbaton.catalogue.mano.common.monitoring.ThresholdDetails;
import org.openbaton.catalogue.mano.common.monitoring.ThresholdType;
import org.openbaton.catalogue.mano.common.monitoring.VRAlarm;
import org.openbaton.catalogue.nfvo.EndpointType;
import org.openbaton.exceptions.MonitoringException;
import org.openbaton.monitoring.agent.ZabbixMonitoringAgent;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

/** Created by pku on 14.12.16. */
public class VirtualizedResourceFaultManagementTest {

  private final String[] hostnameList = {"Zabbix server"};
  private static ZabbixMonitoringAgent zabbixMonitoringAgent;
  private static List<String> subscriptionIds;
  private static List<String> thresholdIds;

  @BeforeClass
  public static void init() throws InterruptedException, MonitoringException, RemoteException {
    zabbixMonitoringAgent = new ZabbixMonitoringAgent();
    subscriptionIds = new ArrayList<String>();
    thresholdIds = new ArrayList<String>();
    Thread.sleep(3000);
  }

  @Test
  public void subscribeAndNotifyTest() throws MonitoringException, InterruptedException {
    AlarmEndpoint alarmEndpoint;
    for (String host : hostnameList) {
      alarmEndpoint =
          new AlarmEndpoint(
              "fm-of-host-" + host,
              host,
              EndpointType.REST,
              "http://localhost:8010/alarm",
              PerceivedSeverity.WARNING);
      String subscriptionId = zabbixMonitoringAgent.subscribeForFault(alarmEndpoint);
      subscriptionIds.add(subscriptionId);

      ThresholdDetails thresholdDetails =
          new ThresholdDetails("last(0)", "=", PerceivedSeverity.CRITICAL, "0", "|");
      thresholdDetails.setPerceivedSeverity(PerceivedSeverity.CRITICAL);
      ObjectSelection objectSelection = new ObjectSelection();
      objectSelection.addObjectInstanceId(host);
      String thresholdId =
          zabbixMonitoringAgent.createThreshold(
              objectSelection, "proc.num[]", ThresholdType.SINGLE_VALUE, thresholdDetails);
      thresholdIds.add(thresholdId);

      AbstractVirtualizedResourceAlarm alarm =
          new VirtualizedResourceAlarmNotification(thresholdId, new VRAlarm());
      zabbixMonitoringAgent.notifyFault(alarmEndpoint, alarm);
      Thread.sleep(10000);
    }
  }

  @AfterClass
  public static void destroy() throws MonitoringException {
    for (String id : subscriptionIds) {
      zabbixMonitoringAgent.unsubscribeForFault(id);
    }
    if (!thresholdIds.isEmpty()) {
      zabbixMonitoringAgent.deletePMJob(thresholdIds);
    }
    zabbixMonitoringAgent.terminate();
  }
}
