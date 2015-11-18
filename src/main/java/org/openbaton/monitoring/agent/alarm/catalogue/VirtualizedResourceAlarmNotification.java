package org.openbaton.monitoring.agent.alarm.catalogue;

/**
 * Created by mob on 27.10.15.
 */
public class VirtualizedResourceAlarmNotification extends AbstractVirtualizedResourceAlarm {
    private Alarm alarm;

    public VirtualizedResourceAlarmNotification(String resourceId, Alarm alarm) {
        super(resourceId);
        this.alarm=alarm;
    }

    public Alarm getAlarm() {
        return alarm;
    }

    public void setAlarm(Alarm alarm) {
        this.alarm = alarm;
    }
}
