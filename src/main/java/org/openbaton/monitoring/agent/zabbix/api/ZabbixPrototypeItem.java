package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mob on 15.01.16.
 */
public class ZabbixPrototypeItem extends ZabbixItem {
    @SerializedName("ruleid")
    @Expose
    private String ruleId;
    public ZabbixPrototypeItem(String name, String key, String hostId, Integer type, Integer valueType, Integer delay) {
        super(name, key, hostId, type, valueType, delay);
    }

    public String getRuleId() {
        return ruleId;
    }

    public void setRuleId(String ruleId) {
        this.ruleId = ruleId;
    }
}
