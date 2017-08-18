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
package org.openbaton.monitoring.agent;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.concurrent.TimeoutException;
import org.openbaton.plugin.PluginStarter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Starter {

  public static void main(String[] args)
      throws IOException, InstantiationException, TimeoutException, IllegalAccessException,
          InvocationTargetException, NoSuchMethodException, InterruptedException {
    Logger log = LoggerFactory.getLogger(Starter.class);
    if (args.length == 4) {
      PluginStarter.registerPlugin(
          ZabbixMonitoringAgent.class,
          args[0],
          args[1],
          Integer.parseInt(args[2]),
          //          Integer.parseInt(args[3]));
          1);
    } else {
      PluginStarter.registerPlugin(ZabbixMonitoringAgent.class, "zabbix", "localhost", 5672, 1);
    }
  }
}
