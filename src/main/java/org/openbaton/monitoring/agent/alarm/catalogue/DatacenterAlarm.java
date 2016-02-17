package org.openbaton.monitoring.agent.alarm.catalogue;

import org.openbaton.catalogue.mano.common.monitoring.Alarm;
import org.openbaton.catalogue.mano.common.monitoring.AlarmType;

/**
 * Created by mob on 27.01.16.
 */
public class DatacenterAlarm extends Alarm {

    private String datacenterName;

    @Override
    public AlarmType getAlarmType() {
        return null;
    }

    @Override
    public void setAlarmType(AlarmType alarmType) {
    }

    public String getDatacenterName() {
        return datacenterName;
    }

    public void setDatacenterName(String datacenterName) {
        this.datacenterName = datacenterName;
    }
}
