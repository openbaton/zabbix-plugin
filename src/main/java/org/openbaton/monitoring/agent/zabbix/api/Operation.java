package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mob on 17.11.15.
 */
public class Operation {


    @SerializedName("operationtype")
    @Expose
    private Integer operationtype;
    @SerializedName("opmessage_usr")
    @Expose
    private List<OpmessageUsr> opmessageUsr = new ArrayList<OpmessageUsr>();
    @SerializedName("opmessage")
    @Expose
    private Opmessage opmessage;

    /**
     *
     * @return
     * The operationtype
     */
    public Integer getOperationtype() {
        return operationtype;
    }

    /**
     *
     * @param operationtype
     * The operationtype
     */
    public void setOperationtype(Integer operationtype) {
        this.operationtype = operationtype;
    }

    /**
     *
     * @return
     * The opmessageUsr
     */
    public List<OpmessageUsr> getOpmessageUsr() {
        return opmessageUsr;
    }

    /**
     *
     * @param opmessageUsr
     * The opmessage_usr
     */
    public void setOpmessageUsr(List<OpmessageUsr> opmessageUsr) {
        this.opmessageUsr = opmessageUsr;
    }

    /**
     *
     * @return
     * The opmessage
     */
    public Opmessage getOpmessage() {
        return opmessage;
    }

    /**
     *
     * @param opmessage
     * The opmessage
     */
    public void setOpmessage(Opmessage opmessage) {
        this.opmessage = opmessage;
    }

}
