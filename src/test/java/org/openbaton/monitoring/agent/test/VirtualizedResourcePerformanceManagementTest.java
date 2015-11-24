package org.openbaton.monitoring.agent.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openbaton.monitoring.agent.ZabbixMonitoringAgent;
import org.openbaton.monitoring.agent.exceptions.MonitoringException;
import org.openbaton.monitoring.agent.interfaces.VirtualisedResourcesPerformanceManagement;
import org.openbaton.monitoring.agent.performance.management.catalogue.ResourceSelector;
import org.openbaton.monitoring.interfaces.ResourcePerformanceManagement;
import org.springframework.util.Assert;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.List;

import static junit.framework.TestCase.assertEquals;

/**
 * Created by mob on 24.11.15.
 */
public class VirtualizedResourcePerformanceManagementTest {

    private ZabbixMonitoringAgent zabbixMonitoringAgent;

    @Before
    public void init() throws RemoteException, InterruptedException {
        zabbixMonitoringAgent = new ZabbixMonitoringAgent();
        Thread.sleep(3000);
    }

    @Test
    public void cretePMJobTest() throws MonitoringException {
        ResourceSelector resourceSelector=getResourceSelector();
        List<String> performanceMetrics=getPerformanceMetrics();
        List<String> pmJobIds = zabbixMonitoringAgent.createPMJob(resourceSelector, performanceMetrics, null, 5, 0);
        Assert.notNull(pmJobIds);
        Assert.notEmpty(pmJobIds);
        assertEquals(pmJobIds.size(),2);
    }

    private ResourceSelector getResourceSelector(){
        List<String> hostnames= new ArrayList<>();
        hostnames.add("iperf-server-536");
        ResourceSelector resourceSelector=new ResourceSelector(hostnames);

        return resourceSelector;
    }

    private List<String> getPerformanceMetrics(){
        List<String> performanceMetrics= new ArrayList<>();
        performanceMetrics.add("net.tcp.listen[5001]");
        performanceMetrics.add("vfs.file.regmatch[/var/log/app.log,\"[Ee]xception\",,]");
        return performanceMetrics;
    }

    @After
    public void stopZabbixMonitoringAgent(){
        zabbixMonitoringAgent.terminate();
    }
}
