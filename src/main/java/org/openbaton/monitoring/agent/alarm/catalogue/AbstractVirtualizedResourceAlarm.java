package org.openbaton.monitoring.agent.alarm.catalogue;

/**
 * Created by mob on 27.10.15.
 */
public abstract class AbstractVirtualizedResourceAlarm {
    private String resourceId;

    public AbstractVirtualizedResourceAlarm(String resourceId) {
        this.resourceId =resourceId;
    }

    public String getResourceId() {
        return resourceId;
    }

    public void setResourceId(String resourceId) {
        this.resourceId = resourceId;
    }
}
