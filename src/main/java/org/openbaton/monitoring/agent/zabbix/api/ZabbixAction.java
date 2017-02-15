package org.openbaton.monitoring.agent.zabbix.api;

import java.util.List;

/** Created by mob on 15/02/2017. */
public interface ZabbixAction {
  String getName();

  void setName(String name);

  Integer getEventsource();

  void setEventsource(Integer eventsource);

  Integer getEvaltype();

  void setEvaltype(Integer evaltype);

  Integer getEscPeriod();

  void setEscPeriod(Integer escPeriod);

  String getDefLongdata();

  void setDefLongdata(String defLongdata);

  List<Condition> getConditions();

  void setConditions(List<Condition> conditions);

  List<Operation> getOperations();

  void setOperations(List<Operation> operations);
}
