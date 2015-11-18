package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by mob on 17.11.15.
 */
public class Opmessage {

    @SerializedName("default_msg")
    @Expose
    private Integer defaultMsg;
    @SerializedName("mediatypeid")
    @Expose
    private String mediatypeid;

    /**
     *
     * @return
     * The defaultMsg
     */
    public Integer getDefaultMsg() {
        return defaultMsg;
    }

    /**
     *
     * @param defaultMsg
     * The default_msg
     */
    public void setDefaultMsg(Integer defaultMsg) {
        this.defaultMsg = defaultMsg;
    }

    /**
     *
     * @return
     * The mediatypeid
     */
    public String getMediatypeid() {
        return mediatypeid;
    }

    /**
     *
     * @param mediatypeid
     * The mediatypeid
     */
    public void setMediatypeid(String mediatypeid) {
        this.mediatypeid = mediatypeid;
    }
}
