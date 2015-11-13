package org.openbaton.monitoring.agent;

/**
 * Created by mob on 13.11.15.
 */
public class ZabbixNotification {
    private String triggerName;
    private TriggerStatus triggerStatus;
    private String triggerSeverity;
    private String triggerUrl;
    private String itemName;
    private String hostName;
    private String itemKey;
    private float itemValue;
    private int eventId;
    private String eventDate;
    private String eventTime;

    public ZabbixNotification() {
    }

    public String getTriggerName() {
        return triggerName;
    }

    public void setTriggerName(String triggerName) {
        this.triggerName = triggerName;
    }

    public TriggerStatus getTriggerStatus() {
        return triggerStatus;
    }

    public void setTriggerStatus(TriggerStatus triggerStatus) {
        this.triggerStatus = triggerStatus;
    }

    public String getTriggerSeverity() {
        return triggerSeverity;
    }

    public void setTriggerSeverity(String triggerSeverity) {
        this.triggerSeverity = triggerSeverity;
    }

    public String getTriggerUrl() {
        return triggerUrl;
    }

    public void setTriggerUrl(String triggerUrl) {
        this.triggerUrl = triggerUrl;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public String getItemKey() {
        return itemKey;
    }

    public void setItemKey(String itemKey) {
        this.itemKey = itemKey;
    }

    public float getItemValue() {
        return itemValue;
    }

    public void setItemValue(float itemValue) {
        this.itemValue = itemValue;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventDate() {
        return eventDate;
    }

    public void setEventDate(String eventDate) {
        this.eventDate = eventDate;
    }

    public String getEventTime() {
        return eventTime;
    }

    public void setEventTime(String eventTime) {
        this.eventTime = eventTime;
    }

    @Override
    public String toString() {
        return "ZabbixNotification{" +
                "triggerName='" + triggerName + '\'' +
                ", triggerStatus=" + triggerStatus +
                ", triggerSeverity='" + triggerSeverity + '\'' +
                ", triggerUrl='" + triggerUrl + '\'' +
                ", itemName='" + itemName + '\'' +
                ", hostName='" + hostName + '\'' +
                ", itemKey='" + itemKey + '\'' +
                ", itemValue=" + itemValue +
                ", eventId=" + eventId +
                ", eventDate='" + eventDate + '\'' +
                ", eventTime='" + eventTime + '\'' +
                '}';
    }

}
