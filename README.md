# Zabbix plugin

Zabbix plugin is an open source project providing a reference implementation of two interfaces of the VIM, based on the ETSI [NFV MANO] specification.
The two interfaces are:
-   VirtualisedResourceFaultManagement
-   VirtualisedResourcePerformanceManagement

A detailed description of the interfaces is in the last ETSI Draft [IFA005_Or-Vi_ref_point_Spec].

## Description

The zabbix-plugin is an implementation of two interfaces of the VIM, in order to be able to use Zabbix in the NFV architecture.  

![Zabbix plugin architecture][zabbix-plugin-architecture]

With the zabbix plugin you can create/delete items, trigger and action on-demand. But this is what Zabbix server already provide...
So the utlity of the plugin is to perform these actions using standard ETSI interfaces.

VirtualisedResourcePerformanceManagement interface  

| Methods             | Description
| ------------------- | --------------
| CREATE PM JOB       |  Create one or more items to be monitored in one or more hosts.
| DELETE PM JOB       |  Delete a PM job.
| QUERY PM JOB        |  Get item values from one or more host. Fast method since the item values are cached.
| SUBSCRIBE           |  Subscribe to a pm job or a threshold in order to be notified.
| NOTIFY              |  Notification method invoked by zabbix plugin, the customer must not invoke directly this method.
| CREATE THRESHOLD    |  Create trigger on a specific item for one or more hosts
| DELETE THRESHOLD    |  Delete a threshold.
| QUERY THRESHOLD     |  Get information about the status of the thresholds

VirtualisedResourceFaultManagement interface  

| Methods             | Description
| ------------------- | --------------
| SUBSCRIBE           |  Subscribe for alarm coming from an host
| NOTIFY              |  Notification method invoked by zabbix plugin, the customer must not invoke directly this method.
| GET ALARM LIST      |  Get alarms and relative status

## Beneficts

1) Make the consumers (NFVO, VNFM) indipendent to the monitoring system.  
2) The communication between the consumers and zabbix-plugin is JSON based, so the customers can be written in any languages.  
3) The values of the items are chached and updated periodically in order to avoid the zabbix server latency.  
4) If your consumer is written in java, we provide a simple class MonitoringPluginCaller which handle the communication via RabbitMQ.

## Prerequisites

The prerequisites are:  

- Zabbix server installed and running  
- RabbitMQ server installed and running  
- Git installed
- Gradle installed
- Create a configuration file called zabbix-plugin.conf in the path /etc/openbaton/plugins/ and fill it with the
configuration parameter explained in the following section.

## Configuration

| Parameter           | Description     | Default
| ------------------- | --------------  | ----------
| zabbix-ip                             |  IP of the Zabbix Server      | 
| zabbix-port                           |  Port of the Zabbix Server    |
| type                                  |  The type of the plugin       | zabbix-plugin
| user-zbx                              |  User of the Zabbix Server    | 
| password-zbx                          |  Password of Zabbix Server    |
| client-request-frequency              |  Update cache period (Basically each time t, the zabbix plugin ask to every items value for all hosts and fill the local cache)   | 15 (seconds)
| history-length                        |  How long is the history. If the client-request-frequency is 10 seconds and history-length 100, we have available the value of the items of the previous 1000 seconds. | 250
| notification-receiver-server-context  |  Context where the zabbix-plugin receive the notifications by the zabbix server. (this function will be documented soon) | /zabbixplugin/notifications 
| notification-receiver-server-port     |  Port where the zabbix-plugin receive the notifications by the zabbix server. | 8010
| external-properties-file              |  Full path of the configuration file.  | /etc/openbaton/plugins/zabbix-plugin.conf

The configuration file should look like the one below:

```bash  

zabbix-ip = xxx.xxx.xxx.xxx
zabbix-ip = xxxxx
type = zabbix-plugin
user-zbx = zabbixUSer
password-zbx = zabbixPassword
client-request-frequency = 10
history-length = 250

notification-receiver-server-context = /zabbixplugin/notifications
notification-receiver-server-port = 8010

external-properties-file=/etc/openbaton/plugins/zabbix-plugin.conf

```

## Getting Started

Once the prerequisites are met, you can clone the following project from git, compile it using gradle and launch it:  

```bash  

git clone link_of_zabbix-plugin
cd zabbix-plugin
git checkout develop
./gradlew build -x test
java -jar build/lib/zabbix-agent-<version>.jar

```

## Using it via MonitoringPluginCaller

In your application insert the following gradle dependency:

```
compile 'org.openbaton:plugin-sdk:0.15-SNAPSHOT'
```
And the reposiory:
```
repositories {
    maven { url "http://get.openbaton.org:8081/nexus/content/groups/public/" }
}
```

Then in your main, obtain the MonitoringPluginCaller as follow:

```java
MonitoringPluginCaller monitoringPluginCaller=null;
try {
      monitoringPluginCaller = new MonitoringPluginCaller("zabbix");
} catch (TimeoutException e) {
    e.printStackTrace();
} catch (NotFoundException e) {
    e.printStackTrace();
}
```

Now you can start using it just invoking the methods of the interfaces. Here is showed the queryPMJob method:

```java

ArrayList<String> hostnames = new ArrayList<String>(); 
hostnames.add("hostA");
ArrayList<String> metrics = new ArrayList<String>(); 
metrics.add("net.tcp.listen[5001]");
List<Item> items = monitoringPluginCaller.queryPMJob(hostnames,metrics,"0");

```

[IFA005_Or-Vi_ref_point_Spec]:https://docbox.etsi.org/isg/nfv/open/Drafts/IFA005_Or-Vi_ref_point_Spec/
[NFV MANO]:http://www.etsi.org/deliver/etsi_gs/NFV-MAN/001_099/001/01.01.01_60/gs_nfv-man001v010101p.pdf
[zabbix-plugin-architecture]:img/zabbix-plugin-architecture.png
