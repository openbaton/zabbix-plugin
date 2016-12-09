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

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.openbaton.catalogue.mano.common.monitoring.Alarm;
import org.openbaton.catalogue.mano.common.monitoring.AlarmEndpoint;
import org.openbaton.catalogue.mano.common.monitoring.ObjectSelection;
import org.openbaton.catalogue.mano.common.monitoring.PerceivedSeverity;
import org.openbaton.catalogue.mano.common.monitoring.ThresholdDetails;
import org.openbaton.catalogue.nfvo.EndpointType;
import org.openbaton.catalogue.nfvo.Item;
import org.openbaton.exceptions.MonitoringException;
import org.openbaton.monitoring.agent.ZabbixMonitoringAgent;
import org.springframework.util.Assert;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * Created by mob on 24.11.15.
 */
public class VirtualizedResourcePerformanceManagementTest {

    private final String[] hostnameList = {"Zabbix server"};
    private ZabbixMonitoringAgent zabbixMonitoringAgent;

    @Before
    public void init() throws RemoteException, InterruptedException, MonitoringException {
        zabbixMonitoringAgent = new ZabbixMonitoringAgent();
        Thread.sleep(3000);
    }

    @Test
    public void createAndDeletePMJobTest() throws MonitoringException {
        ObjectSelection objectSelection = getObjectSelector(hostnameList);
        List<String> performanceMetrics=getPerformanceMetrics("net.tcp.listen[8081]", "net.tcp.listen[8080]");
        String pmJobId = zabbixMonitoringAgent.createPMJob(objectSelection, performanceMetrics,
                                                           new ArrayList<String>(),10, 0);
        Assert.notNull(pmJobId);
        Assert.isTrue(!pmJobId.isEmpty());

        List<String> pmJobIdToDelete=new ArrayList<>();
        pmJobIdToDelete.add(pmJobId);
        List<String> pmJobIdDeleted= zabbixMonitoringAgent.deletePMJob(pmJobIdToDelete);

        Assert.isTrue(pmJobIdDeleted.get(0).equals(pmJobId));
    }

    @Test
    public void createAndDeleteThresholdTest() throws MonitoringException {
        ObjectSelection objectSelector= getObjectSelector(hostnameList);
        ThresholdDetails thresholdDetails= new ThresholdDetails("last(0)","=",
                                                                PerceivedSeverity.CRITICAL,"0","|");
        thresholdDetails.setPerceivedSeverity(PerceivedSeverity.CRITICAL);

        String thresholdId = zabbixMonitoringAgent.createThreshold(objectSelector,
                                                                   "proc.num[]",
                                                                   null,thresholdDetails);

        List<String> thresholdIdsToDelete=new ArrayList<>();
        thresholdIdsToDelete.add(thresholdId);

        List<String> thresholdIdsDeleted = zabbixMonitoringAgent.deleteThreshold(thresholdIdsToDelete);
        Assert.isTrue(thresholdId.equals(thresholdIdsDeleted.get(0)));
    }

    @Test
    public void getMetricsTest() throws MonitoringException {
        ObjectSelection objectSelector = getObjectSelector(hostnameList);
        List<String> itemList = new ArrayList<String>(Arrays.asList("agent.ping", "proc.num[]"));
        List<Item> metrics = zabbixMonitoringAgent.queryPMJob(objectSelector.getObjectInstanceIds(),
                                                              itemList, "0");
    }

    @Test
    @Ignore
    public void checkRequestTest() {}

    @Test
    public void alarmGetCheckAndDeleteTest() throws MonitoringException {
        List<Alarm> alarmList = zabbixMonitoringAgent.getAlarmList("something", PerceivedSeverity.CRITICAL);
        AlarmEndpoint alarmEndpoint = new AlarmEndpoint("testalarm",
                                                        null, EndpointType.REST,
                                                        "http://localhost:9001/alarm/vr",
                                                        PerceivedSeverity.MINOR);
        String subscribtionId = zabbixMonitoringAgent.subscribeForFault(alarmEndpoint);
        zabbixMonitoringAgent.unsubscribeForFault(subscribtionId);
    }

    private ObjectSelection getObjectSelector(String ... args){
        ObjectSelection objectSelection =new ObjectSelection();
        for(String arg : args){
            objectSelection.addObjectInstanceId(arg);
        }
        return objectSelection;
    }

    private List<String> getPerformanceMetrics(String ... args){
        List<String> performanceMetrics= new ArrayList<>();
        Collections.addAll(performanceMetrics, args);
        return performanceMetrics;
    }

    @After
    public void stopZabbixMonitoringAgent(){
        zabbixMonitoringAgent.terminate();
    }
}
