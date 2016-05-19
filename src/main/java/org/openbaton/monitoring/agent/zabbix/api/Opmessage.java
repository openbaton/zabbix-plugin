/*
* Copyright (c) 2015-2016 Fraunhofer FOKUS
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

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
