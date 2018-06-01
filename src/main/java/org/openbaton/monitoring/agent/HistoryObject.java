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

package org.openbaton.monitoring.agent;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/** Created by tbr on 27.10.15. */
public class HistoryObject implements Serializable {

  private static final long serialVersionUID = 1L;

  private String hostId = "";
  private Map<String, String> measurements = new HashMap<String, String>();
  private Map<String, String> units = new HashMap<String, String>();

  public String getHostId() {
    return hostId;
  }

  public void setHostId(String hostId) {
    this.hostId = hostId;
  }

  public void setMeasurement(String key, String value) {
    measurements.put(key, value);
  }

  public String getMeasurement(String key) {
    return measurements.get(key);
  }

  public void setUnit(String key, String value) {
    units.put(key, value);
  }

  public String getUnit(String key) {
    return units.get(key);
  }

  public boolean keyExists(String key) {
    return measurements.containsKey(key);
  }

  @Override
  public String toString() {
    return "HistoryObject{"
        + "hostId='"
        + hostId
        + '\''
        + ", measurements="
        + measurements
        + ", units="
        + units
        + '}';
  }
}
