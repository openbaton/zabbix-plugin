/*
 * Copyright (c) 2015 Fraunhofer FOKUS
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

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.openbaton.exceptions.MonitoringException;
import org.openbaton.monitoring.agent.ZabbixSender;
import org.openbaton.monitoring.agent.zabbix.api.ZabbixApiManager;
import org.springframework.util.Assert;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

/**
 * Created by mob on 25.11.15.
 */
public class ZabbixApiManagerTest {

    private ZabbixApiManager zabbixApiManager;

    @Before
    public void init() throws IOException {
        Properties properties = new Properties();
        properties.load(this.getClass().getResourceAsStream("/plugin.conf.properties"));
        if (properties.getProperty("external-properties-file") != null) {
            File externalPropertiesFile = new File(properties.getProperty("external-properties-file"));
            if (externalPropertiesFile.exists()) {
                InputStream is = new FileInputStream(externalPropertiesFile);
                properties.load(is);
            }
        }
        ZabbixSender zabbixSender = new ZabbixSender(properties.getProperty("zabbix-ip"),properties.getProperty("zabbix-port"),properties.getProperty("user"), properties.getProperty("password"));
        zabbixApiManager= new ZabbixApiManager(zabbixSender);
    }

    @Test
    @Ignore
    public void createAndDeleteActionAndTriggerTest() throws MonitoringException {

        String triggerId = zabbixApiManager.createTrigger("Test trigger","{iperf-server-536:system.cpu.load[percpu,avg1].last(0)}>0.45",3/*average*/);

        String actionId = zabbixApiManager.createAction("Test action", triggerId);

        List<String> idsToDelete = new ArrayList<>();
        idsToDelete.add(actionId);
        List<String> actionIdDeleted = zabbixApiManager.deleteActions(idsToDelete);
        Assert.isTrue(idsToDelete.get(0).equals(actionIdDeleted.get(0)));

        idsToDelete.clear();
        idsToDelete.add(triggerId);
        List<String> triggerIdDeleted = zabbixApiManager.deleteTriggers(idsToDelete);
        Assert.isTrue(idsToDelete.get(0).equals(triggerIdDeleted.get(0)));
    }
}
