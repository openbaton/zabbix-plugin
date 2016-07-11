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
 * Created by mob on 18.11.15.
 */
public class ZabbixItem {
  @SerializedName("name")
  @Expose
  private String name;

  @SerializedName("key_")
  @Expose
  private String key;

  @SerializedName("hostid")
  @Expose
  private String hostId;

  @SerializedName("type")
  @Expose
  private Integer type;

  @SerializedName("value_type")
  @Expose
  private Integer valueType;

  @SerializedName("interfaceid")
  @Expose
  private String interfaceId;

  @SerializedName("delay")
  @Expose
  private Integer delay;

  public ZabbixItem(
      String name, String key, String hostId, Integer type, Integer valueType, Integer delay) {
    this.name = name;
    this.key = key;
    this.hostId = hostId;
    this.type = type;
    this.valueType = valueType;
    this.delay = delay;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public String getKey() {
    return key;
  }

  public void setKey(String key) {
    this.key = key;
  }

  public String getHostId() {
    return hostId;
  }

  public void setHostId(String hostId) {
    this.hostId = hostId;
  }

  public Integer getType() {
    return type;
  }

  public void setType(Integer type) {
    this.type = type;
  }

  public Integer getValueType() {
    return valueType;
  }

  public void setValueType(Integer valueType) {
    this.valueType = valueType;
  }

  public String getInterfaceId() {
    return interfaceId;
  }

  public void setInterfaceId(String interfaceId) {
    this.interfaceId = interfaceId;
  }

  public Integer getDelay() {
    return delay;
  }

  public void setDelay(Integer delay) {
    this.delay = delay;
  }
}
