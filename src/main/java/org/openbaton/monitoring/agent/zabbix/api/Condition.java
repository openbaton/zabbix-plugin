package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mob on 17.11.15.
 */
public class Condition {


    @SerializedName("conditiontype")
    @Expose
    private Integer conditiontype;
    @SerializedName("value")
    @Expose
    private String value;
    @SerializedName("operator")
    @Expose
    private Integer operator;

    /**
     *
     * @return
     * The conditiontype
     */
    public Integer getConditiontype() {
        return conditiontype;
    }

    /**
     *
     * @param conditiontype
     * The conditiontype
     */
    public void setConditiontype(Integer conditiontype) {
        this.conditiontype = conditiontype;
    }

    /**
     *
     * @return
     * The value
     */
    public String getValue() {
        return value;
    }

    /**
     *
     * @param value
     * The value
     */
    public void setValue(String value) {
        this.value = value;
    }

    /**
     *
     * @return
     * The operator
     */
    public Integer getOperator() {
        return operator;
    }

    /**
     *
     * @param operator
     * The operator
     */
    public void setOperator(Integer operator) {
        this.operator = operator;
    }

}
