package org.openbaton.monitoring.agent.alarm.catalogue;

/**
 * Created by mob on 28.10.15.
 */
public class VirtualizedResourceAlarmStateChangedNotification extends AbstractVirtualizedResourceAlarm {
    private AlarmState alarmState;

    public VirtualizedResourceAlarmStateChangedNotification(String resourceId, AlarmState alarmState) {
        super(resourceId);
        this.alarmState=alarmState;

    }

    public AlarmState getAlarmState() {
        return alarmState;
    }

    public void setAlarmState(AlarmState alarmState) {
        this.alarmState = alarmState;
    }
}
