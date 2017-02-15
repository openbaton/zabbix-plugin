package org.openbaton.monitoring.agent.zabbix.api;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import java.util.ArrayList;
import java.util.List;

/** Created by mob on 15/02/2017. */
public class Filter {
  @SerializedName("conditions")
  @Expose
  private List<Condition> conditions = new ArrayList<>();

  @SerializedName("evaltype")
  @Expose
  private Integer evaltype;

  public List<Condition> getConditions() {
    return conditions;
  }

  public void setConditions(List<Condition> conditions) {
    this.conditions = conditions;
  }

  public Integer getEvaltype() {
    return evaltype;
  }

  public void setEvaltype(Integer evaltype) {
    this.evaltype = evaltype;
  }
}
