package org.openbaton.monitoring.agent;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by tbr on 27.10.15.
 */
public class HistoryObject implements Serializable {

    private static final long serialVersionUID = 1L;

    private long timestamp = 0;

    public String getHostId() {
        return hostId;
    }

    public void setHostId(String hostId) {
        this.hostId = hostId;
    }

    private String hostId = "";
    private Map<String, String> measurements = new HashMap<String, String>();

    public HistoryObject(long timestamp) {
        this.timestamp = timestamp;
    }

    public void setTimestamp(long time) {
        this.timestamp = time;
    }

    public long getTimestamp() {
        return this.timestamp;
    }


    public void setMeasurement(String key, String value) {
        measurements.put(key, value);
    }

    public String getMeasurement(String key) {
        return measurements.get(key);
    }

    public boolean keyExists(String key) {
        return measurements.containsKey(key);
    }



}
