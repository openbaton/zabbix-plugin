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

package org.openbaton.monitoring.agent;

import org.openbaton.monitoring.agent.HistoryObject;

import java.util.Map;

/**
 * Created by tbr on 30.10.15.
 */

/**
 * Represents the state of zabbix at a specific point of time.
 */
public class State {

    private Long time;
    private Map<String, HistoryObject> hostsHistory;

    public State(Long time, Map<String, HistoryObject> hostsHistory) {
        this.time = time;
        this.hostsHistory = hostsHistory;
    }

    public Long getTime() {
        return time;
    }

    public Map<String, HistoryObject> getHostsHistory() {
        return hostsHistory;
    }
}
