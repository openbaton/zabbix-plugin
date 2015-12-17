package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mob on 17.11.15.
 */
public class ZabbixAction {
    @SerializedName("name")
    @Expose
    private String name;
    @SerializedName("eventsource")
    @Expose
    private Integer eventsource;
    @SerializedName("evaltype")
    @Expose
    private Integer evaltype;
    @SerializedName("esc_period")
    @Expose
    private Integer escPeriod;
    @SerializedName("def_longdata")
    @Expose
    private String defLongdata;
    @SerializedName("conditions")
    @Expose
    private List<Condition> conditions = new ArrayList<Condition>();
    @SerializedName("operations")
    @Expose
    private List<Operation> operations = new ArrayList<Operation>();

    /**
     *
     * @return
     * The name
     */
    public String getName() {
        return name;
    }

    /**
     *
     * @param name
     * The name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     *
     * @return
     * The eventsource
     */
    public Integer getEventsource() {
        return eventsource;
    }

    /**
     *
     * @param eventsource
     * The eventsource
     */
    public void setEventsource(Integer eventsource) {
        this.eventsource = eventsource;
    }

    /**
     *
     * @return
     * The evaltype
     */
    public Integer getEvaltype() {
        return evaltype;
    }

    /**
     *
     * @param evaltype
     * The evaltype
     */
    public void setEvaltype(Integer evaltype) {
        this.evaltype = evaltype;
    }

    /**
     *
     * @return
     * The escPeriod
     */
    public Integer getEscPeriod() {
        return escPeriod;
    }

    /**
     *
     * @param escPeriod
     * The esc_period
     */
    public void setEscPeriod(Integer escPeriod) {
        this.escPeriod = escPeriod;
    }

    /**
     *
     * @return
     * The defLongdata
     */
    public String getDefLongdata() {
        return defLongdata;
    }

    /**
     *
     * @param defLongdata
     * The def_longdata
     */
    public void setDefLongdata(String defLongdata) {
        this.defLongdata = defLongdata;
    }

    /**
     *
     * @return
     * The conditions
     */
    public List<Condition> getConditions() {
        return conditions;
    }

    /**
     *
     * @param conditions
     * The conditions
     */
    public void setConditions(List<Condition> conditions) {
        this.conditions = conditions;
    }

    /**
     *
     * @return
     * The operations
     */
    public List<Operation> getOperations() {
        return operations;
    }

    /**
     *
     * @param operations
     * The operations
     */
    public void setOperations(List<Operation> operations) {
        this.operations = operations;
    }

}
