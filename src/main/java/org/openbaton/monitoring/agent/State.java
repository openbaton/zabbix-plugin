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
