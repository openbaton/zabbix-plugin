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
   * @return The operationtype
   */
  public Integer getOperationtype() {
    return operationtype;
  }

  /**
   *
   * @param operationtype The operationtype
   */
  public void setOperationtype(Integer operationtype) {
    this.operationtype = operationtype;
  }

  /**
   *
   * @return The opmessageUsr
   */
  public List<OpmessageUsr> getOpmessageUsr() {
    return opmessageUsr;
  }

  /**
   *
   * @param opmessageUsr The opmessage_usr
   */
  public void setOpmessageUsr(List<OpmessageUsr> opmessageUsr) {
    this.opmessageUsr = opmessageUsr;
  }

  /**
   *
   * @return The opmessage
   */
  public Opmessage getOpmessage() {
    return opmessage;
  }

  /**
   *
   * @param opmessage The opmessage
   */
  public void setOpmessage(Opmessage opmessage) {
    this.opmessage = opmessage;
  }
}
