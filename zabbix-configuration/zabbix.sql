-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: zabbix
-- ------------------------------------------------------
-- Server version	5.5.46-0ubuntu0.14.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `acknowledges`
--

DROP TABLE IF EXISTS `acknowledges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acknowledges` (
  `acknowledgeid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `message` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`acknowledgeid`),
  KEY `acknowledges_1` (`userid`),
  KEY `acknowledges_2` (`eventid`),
  KEY `acknowledges_3` (`clock`),
  CONSTRAINT `c_acknowledges_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_acknowledges_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acknowledges`
--

LOCK TABLES `acknowledges` WRITE;
/*!40000 ALTER TABLE `acknowledges` DISABLE KEYS */;
/*!40000 ALTER TABLE `acknowledges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `actionid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `eventsource` int(11) NOT NULL DEFAULT '0',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `esc_period` int(11) NOT NULL DEFAULT '0',
  `def_shortdata` varchar(255) NOT NULL DEFAULT '',
  `def_longdata` text NOT NULL,
  `recovery_msg` int(11) NOT NULL DEFAULT '0',
  `r_shortdata` varchar(255) NOT NULL DEFAULT '',
  `r_longdata` text NOT NULL,
  PRIMARY KEY (`actionid`),
  KEY `actions_1` (`eventsource`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (2,'Auto discovery. Linux servers.',1,0,1,0,'','',0,'',''),(3,'Report problems to Zabbix administrators',0,0,1,3600,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}',1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}\r\n\r\nOriginal event ID: {EVENT.ID}'),(4,'Report not supported items',3,0,1,3600,'{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}',1,'{ITEM.STATE}: {HOST.NAME}:{ITEM.NAME}','Host: {HOST.NAME}\r\nItem: {ITEM.NAME}\r\nKey: {ITEM.KEY}\r\nState: {ITEM.STATE}'),(5,'Report not supported low level discovery rules',3,0,1,3600,'{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}',1,'{LLDRULE.STATE}: {HOST.NAME}:{LLDRULE.NAME}','Host: {HOST.NAME}\r\nLow level discovery rule: {LLDRULE.NAME}\r\nKey: {LLDRULE.KEY}\r\nState: {LLDRULE.STATE}'),(6,'Report unknown triggers',3,0,1,3600,'{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}',1,'{TRIGGER.STATE}: {TRIGGER.NAME}','Trigger name: {TRIGGER.NAME}\r\nExpression: {TRIGGER.EXPRESSION}\r\nState: {TRIGGER.STATE}'),(7,'add host',2,0,0,0,'Auto registration: {HOST.HOST}','Host name: {HOST.HOST}\r\nHost IP: {HOST.IP}\r\nAgent port: {HOST.PORT}',0,'','');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `alertid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `eventid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned DEFAULT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  `sendto` varchar(100) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `retries` int(11) NOT NULL DEFAULT '0',
  `error` varchar(128) NOT NULL DEFAULT '',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `alerttype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`alertid`),
  KEY `alerts_1` (`actionid`),
  KEY `alerts_2` (`clock`),
  KEY `alerts_3` (`eventid`),
  KEY `alerts_4` (`status`,`retries`),
  KEY `alerts_5` (`mediatypeid`),
  KEY `alerts_6` (`userid`),
  CONSTRAINT `c_alerts_4` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_2` FOREIGN KEY (`eventid`) REFERENCES `events` (`eventid`) ON DELETE CASCADE,
  CONSTRAINT `c_alerts_3` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `application_template`
--

DROP TABLE IF EXISTS `application_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `application_template` (
  `application_templateid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`application_templateid`),
  UNIQUE KEY `application_template_1` (`applicationid`,`templateid`),
  KEY `application_template_2` (`templateid`),
  CONSTRAINT `c_application_template_2` FOREIGN KEY (`templateid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE,
  CONSTRAINT `c_application_template_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `application_template`
--

LOCK TABLES `application_template` WRITE;
/*!40000 ALTER TABLE `application_template` DISABLE KEYS */;
INSERT INTO `application_template` VALUES (1,207,206),(2,229,228),(3,230,227),(4,231,228),(5,232,227),(6,235,234),(7,236,234),(8,237,228),(9,238,227),(10,241,240),(11,242,240),(12,252,206),(13,262,206),(14,272,206),(15,282,206),(16,292,206),(17,302,206),(18,329,206),(19,345,179),(20,346,13),(21,347,5),(22,348,21),(23,349,15),(24,350,7),(25,351,1),(26,352,17),(27,353,9),(28,354,23),(29,355,207);
/*!40000 ALTER TABLE `application_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `applicationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `applications_2` (`hostid`,`name`),
  CONSTRAINT `c_applications_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (13,10001,'CPU'),(5,10001,'Filesystems'),(21,10001,'General'),(15,10001,'Memory'),(7,10001,'Network interfaces'),(1,10001,'OS'),(17,10001,'Performance'),(9,10001,'Processes'),(23,10001,'Security'),(207,10001,'Zabbix agent'),(179,10047,'Zabbix server'),(356,10048,'Zabbix proxy'),(206,10050,'Zabbix agent'),(227,10060,'Interfaces'),(228,10065,'General'),(229,10066,'General'),(230,10066,'Interfaces'),(235,10067,'Disk partitions'),(231,10067,'General'),(232,10067,'Interfaces'),(242,10067,'Processors'),(234,10068,'Disk partitions'),(236,10069,'Disk partitions'),(237,10069,'General'),(238,10069,'Interfaces'),(241,10069,'Processors'),(240,10070,'Processors'),(247,10071,'Fans'),(246,10071,'Temperature'),(245,10071,'Voltage'),(250,10072,'Fans'),(249,10072,'Temperature'),(248,10072,'Voltage'),(251,10073,'MySQL'),(253,10074,'CPU'),(254,10074,'Filesystems'),(255,10074,'General'),(256,10074,'Memory'),(257,10074,'Network interfaces'),(258,10074,'OS'),(259,10074,'Performance'),(260,10074,'Processes'),(261,10074,'Security'),(252,10074,'Zabbix agent'),(263,10075,'CPU'),(264,10075,'Filesystems'),(265,10075,'General'),(266,10075,'Memory'),(267,10075,'Network interfaces'),(268,10075,'OS'),(269,10075,'Performance'),(270,10075,'Processes'),(271,10075,'Security'),(262,10075,'Zabbix agent'),(273,10076,'CPU'),(274,10076,'Filesystems'),(275,10076,'General'),(331,10076,'Logical partitions'),(276,10076,'Memory'),(277,10076,'Network interfaces'),(278,10076,'OS'),(279,10076,'Performance'),(280,10076,'Processes'),(281,10076,'Security'),(272,10076,'Zabbix agent'),(283,10077,'CPU'),(284,10077,'Filesystems'),(285,10077,'General'),(286,10077,'Memory'),(287,10077,'Network interfaces'),(288,10077,'OS'),(289,10077,'Performance'),(290,10077,'Processes'),(291,10077,'Security'),(282,10077,'Zabbix agent'),(293,10078,'CPU'),(294,10078,'Filesystems'),(295,10078,'General'),(296,10078,'Memory'),(297,10078,'Network interfaces'),(298,10078,'OS'),(299,10078,'Performance'),(300,10078,'Processes'),(301,10078,'Security'),(292,10078,'Zabbix agent'),(303,10079,'CPU'),(304,10079,'Filesystems'),(305,10079,'General'),(306,10079,'Memory'),(307,10079,'Network interfaces'),(308,10079,'OS'),(309,10079,'Performance'),(310,10079,'Processes'),(311,10079,'Security'),(302,10079,'Zabbix agent'),(325,10081,'CPU'),(322,10081,'Filesystems'),(319,10081,'General'),(328,10081,'Memory'),(330,10081,'Network interfaces'),(323,10081,'OS'),(320,10081,'Performance'),(324,10081,'Processes'),(329,10081,'Zabbix agent'),(332,10082,'Classes'),(333,10082,'Compilation'),(334,10082,'Garbage Collector'),(335,10082,'Memory'),(336,10082,'Memory Pool'),(337,10082,'Operating System'),(338,10082,'Runtime'),(339,10082,'Threads'),(340,10083,'http-8080'),(341,10083,'http-8443'),(342,10083,'jk-8009'),(343,10083,'Sessions'),(344,10083,'Tomcat'),(346,10084,'CPU'),(347,10084,'Filesystems'),(348,10084,'General'),(349,10084,'Memory'),(350,10084,'Network interfaces'),(351,10084,'OS'),(352,10084,'Performance'),(353,10084,'Processes'),(354,10084,'Security'),(355,10084,'Zabbix agent'),(345,10084,'Zabbix server'),(434,10088,'Clusters'),(458,10088,'General'),(433,10088,'Log'),(408,10089,'CPU'),(435,10089,'Disks'),(424,10089,'Filesystems'),(412,10089,'General'),(437,10089,'Interfaces'),(410,10089,'Memory'),(428,10089,'Network'),(414,10089,'Storage'),(416,10091,'CPU'),(445,10091,'Datastore'),(418,10091,'General'),(420,10091,'Hardware'),(422,10091,'Memory'),(443,10091,'Network'),(446,10093,'FTP service'),(447,10094,'HTTP service'),(448,10095,'HTTPS service'),(449,10096,'IMAP service'),(450,10097,'LDAP service'),(451,10098,'NNTP service'),(452,10099,'NTP service'),(453,10100,'POP service'),(454,10101,'SMTP service'),(455,10102,'SSH service'),(456,10103,'Telnet service'),(457,10104,'ICMP');
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `auditid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `action` int(11) NOT NULL DEFAULT '0',
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `details` varchar(128) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `resourcename` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`auditid`),
  KEY `auditlog_1` (`userid`,`clock`),
  KEY `auditlog_2` (`clock`),
  CONSTRAINT `c_auditlog_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
INSERT INTO `auditlog` VALUES (1,1,1450349368,3,0,'0','10.147.66.151',1,''),(2,1,1450349718,0,5,'Name: add host','10.147.66.151',0,'');
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditlog_details`
--

DROP TABLE IF EXISTS `auditlog_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog_details` (
  `auditdetailid` bigint(20) unsigned NOT NULL,
  `auditid` bigint(20) unsigned NOT NULL,
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `field_name` varchar(64) NOT NULL DEFAULT '',
  `oldvalue` text NOT NULL,
  `newvalue` text NOT NULL,
  PRIMARY KEY (`auditdetailid`),
  KEY `auditlog_details_1` (`auditid`),
  CONSTRAINT `c_auditlog_details_1` FOREIGN KEY (`auditid`) REFERENCES `auditlog` (`auditid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog_details`
--

LOCK TABLES `auditlog_details` WRITE;
/*!40000 ALTER TABLE `auditlog_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditlog_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `autoreg_host`
--

DROP TABLE IF EXISTS `autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autoreg_host` (
  `autoreg_hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(64) NOT NULL DEFAULT '',
  `host_metadata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`autoreg_hostid`),
  KEY `autoreg_host_1` (`proxy_hostid`,`host`),
  CONSTRAINT `c_autoreg_host_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autoreg_host`
--

LOCK TABLES `autoreg_host` WRITE;
/*!40000 ALTER TABLE `autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conditions`
--

DROP TABLE IF EXISTS `conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conditions` (
  `conditionid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`conditionid`),
  KEY `conditions_1` (`actionid`),
  CONSTRAINT `c_conditions_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conditions`
--

LOCK TABLES `conditions` WRITE;
/*!40000 ALTER TABLE `conditions` DISABLE KEYS */;
INSERT INTO `conditions` VALUES (2,2,10,0,'0'),(3,2,8,0,'9'),(4,2,12,2,'Linux'),(5,3,16,7,''),(6,3,5,0,'1'),(7,4,23,0,'0'),(8,5,23,0,'2'),(9,6,23,0,'4');
/*!40000 ALTER TABLE `conditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `configid` bigint(20) unsigned NOT NULL,
  `refresh_unsupported` int(11) NOT NULL DEFAULT '0',
  `work_period` varchar(100) NOT NULL DEFAULT '1-5,00:00-24:00',
  `alert_usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `event_ack_enable` int(11) NOT NULL DEFAULT '1',
  `event_expire` int(11) NOT NULL DEFAULT '7',
  `event_show_max` int(11) NOT NULL DEFAULT '100',
  `default_theme` varchar(128) NOT NULL DEFAULT 'originalblue',
  `authentication_type` int(11) NOT NULL DEFAULT '0',
  `ldap_host` varchar(255) NOT NULL DEFAULT '',
  `ldap_port` int(11) NOT NULL DEFAULT '389',
  `ldap_base_dn` varchar(255) NOT NULL DEFAULT '',
  `ldap_bind_dn` varchar(255) NOT NULL DEFAULT '',
  `ldap_bind_password` varchar(128) NOT NULL DEFAULT '',
  `ldap_search_attribute` varchar(128) NOT NULL DEFAULT '',
  `dropdown_first_entry` int(11) NOT NULL DEFAULT '1',
  `dropdown_first_remember` int(11) NOT NULL DEFAULT '1',
  `discovery_groupid` bigint(20) unsigned NOT NULL,
  `max_in_table` int(11) NOT NULL DEFAULT '50',
  `search_limit` int(11) NOT NULL DEFAULT '1000',
  `severity_color_0` varchar(6) NOT NULL DEFAULT 'DBDBDB',
  `severity_color_1` varchar(6) NOT NULL DEFAULT 'D6F6FF',
  `severity_color_2` varchar(6) NOT NULL DEFAULT 'FFF6A5',
  `severity_color_3` varchar(6) NOT NULL DEFAULT 'FFB689',
  `severity_color_4` varchar(6) NOT NULL DEFAULT 'FF9999',
  `severity_color_5` varchar(6) NOT NULL DEFAULT 'FF3838',
  `severity_name_0` varchar(32) NOT NULL DEFAULT 'Not classified',
  `severity_name_1` varchar(32) NOT NULL DEFAULT 'Information',
  `severity_name_2` varchar(32) NOT NULL DEFAULT 'Warning',
  `severity_name_3` varchar(32) NOT NULL DEFAULT 'Average',
  `severity_name_4` varchar(32) NOT NULL DEFAULT 'High',
  `severity_name_5` varchar(32) NOT NULL DEFAULT 'Disaster',
  `ok_period` int(11) NOT NULL DEFAULT '1800',
  `blink_period` int(11) NOT NULL DEFAULT '1800',
  `problem_unack_color` varchar(6) NOT NULL DEFAULT 'DC0000',
  `problem_ack_color` varchar(6) NOT NULL DEFAULT 'DC0000',
  `ok_unack_color` varchar(6) NOT NULL DEFAULT '00AA00',
  `ok_ack_color` varchar(6) NOT NULL DEFAULT '00AA00',
  `problem_unack_style` int(11) NOT NULL DEFAULT '1',
  `problem_ack_style` int(11) NOT NULL DEFAULT '1',
  `ok_unack_style` int(11) NOT NULL DEFAULT '1',
  `ok_ack_style` int(11) NOT NULL DEFAULT '1',
  `snmptrap_logging` int(11) NOT NULL DEFAULT '1',
  `server_check_interval` int(11) NOT NULL DEFAULT '10',
  `hk_events_mode` int(11) NOT NULL DEFAULT '1',
  `hk_events_trigger` int(11) NOT NULL DEFAULT '365',
  `hk_events_internal` int(11) NOT NULL DEFAULT '365',
  `hk_events_discovery` int(11) NOT NULL DEFAULT '365',
  `hk_events_autoreg` int(11) NOT NULL DEFAULT '365',
  `hk_services_mode` int(11) NOT NULL DEFAULT '1',
  `hk_services` int(11) NOT NULL DEFAULT '365',
  `hk_audit_mode` int(11) NOT NULL DEFAULT '1',
  `hk_audit` int(11) NOT NULL DEFAULT '365',
  `hk_sessions_mode` int(11) NOT NULL DEFAULT '1',
  `hk_sessions` int(11) NOT NULL DEFAULT '365',
  `hk_history_mode` int(11) NOT NULL DEFAULT '1',
  `hk_history_global` int(11) NOT NULL DEFAULT '0',
  `hk_history` int(11) NOT NULL DEFAULT '90',
  `hk_trends_mode` int(11) NOT NULL DEFAULT '1',
  `hk_trends_global` int(11) NOT NULL DEFAULT '0',
  `hk_trends` int(11) NOT NULL DEFAULT '365',
  PRIMARY KEY (`configid`),
  KEY `config_1` (`alert_usrgrpid`),
  KEY `config_2` (`discovery_groupid`),
  CONSTRAINT `c_config_2` FOREIGN KEY (`discovery_groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_config_1` FOREIGN KEY (`alert_usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,600,'1-5,09:00-18:00;',7,1,7,100,'originalblue',0,'',389,'','','','',1,1,5,50,1000,'DBDBDB','D6F6FF','FFF6A5','FFB689','FF9999','FF3838','Not classified','Information','Warning','Average','High','Disaster',1800,1800,'DC0000','DC0000','00AA00','00AA00',1,1,1,1,1,10,1,365,365,365,365,1,365,1,365,1,365,1,0,90,1,0,365);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dbversion`
--

DROP TABLE IF EXISTS `dbversion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dbversion` (
  `mandatory` int(11) NOT NULL DEFAULT '0',
  `optional` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dbversion`
--

LOCK TABLES `dbversion` WRITE;
/*!40000 ALTER TABLE `dbversion` DISABLE KEYS */;
INSERT INTO `dbversion` VALUES (2020000,2020001);
/*!40000 ALTER TABLE `dbversion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dchecks`
--

DROP TABLE IF EXISTS `dchecks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dchecks` (
  `dcheckid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `snmp_community` varchar(255) NOT NULL DEFAULT '',
  `ports` varchar(255) NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `uniq` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`dcheckid`),
  KEY `dchecks_1` (`druleid`),
  CONSTRAINT `c_dchecks_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dchecks`
--

LOCK TABLES `dchecks` WRITE;
/*!40000 ALTER TABLE `dchecks` DISABLE KEYS */;
INSERT INTO `dchecks` VALUES (2,2,9,'system.uname','','10050','',0,'','',0,0,0,'');
/*!40000 ALTER TABLE `dchecks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dhosts`
--

DROP TABLE IF EXISTS `dhosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dhosts` (
  `dhostid` bigint(20) unsigned NOT NULL,
  `druleid` bigint(20) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dhostid`),
  KEY `dhosts_1` (`druleid`),
  CONSTRAINT `c_dhosts_1` FOREIGN KEY (`druleid`) REFERENCES `drules` (`druleid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dhosts`
--

LOCK TABLES `dhosts` WRITE;
/*!40000 ALTER TABLE `dhosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `dhosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drules`
--

DROP TABLE IF EXISTS `drules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drules` (
  `druleid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `iprange` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '3600',
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`druleid`),
  KEY `drules_1` (`proxy_hostid`),
  CONSTRAINT `c_drules_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drules`
--

LOCK TABLES `drules` WRITE;
/*!40000 ALTER TABLE `drules` DISABLE KEYS */;
INSERT INTO `drules` VALUES (2,NULL,'Local network','192.168.0.1-254',3600,0,1);
/*!40000 ALTER TABLE `drules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dservices`
--

DROP TABLE IF EXISTS `dservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dservices` (
  `dserviceid` bigint(20) unsigned NOT NULL,
  `dhostid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `lastup` int(11) NOT NULL DEFAULT '0',
  `lastdown` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned NOT NULL,
  `ip` varchar(39) NOT NULL DEFAULT '',
  `dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`dserviceid`),
  UNIQUE KEY `dservices_1` (`dcheckid`,`type`,`key_`,`ip`,`port`),
  KEY `dservices_2` (`dhostid`),
  CONSTRAINT `c_dservices_2` FOREIGN KEY (`dcheckid`) REFERENCES `dchecks` (`dcheckid`) ON DELETE CASCADE,
  CONSTRAINT `c_dservices_1` FOREIGN KEY (`dhostid`) REFERENCES `dhosts` (`dhostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dservices`
--

LOCK TABLES `dservices` WRITE;
/*!40000 ALTER TABLE `dservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `dservices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `escalations`
--

DROP TABLE IF EXISTS `escalations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `escalations` (
  `escalationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `eventid` bigint(20) unsigned DEFAULT NULL,
  `r_eventid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `esc_step` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `itemid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`escalationid`),
  UNIQUE KEY `escalations_1` (`actionid`,`triggerid`,`itemid`,`escalationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `escalations`
--

LOCK TABLES `escalations` WRITE;
/*!40000 ALTER TABLE `escalations` DISABLE KEYS */;
/*!40000 ALTER TABLE `escalations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `eventid` bigint(20) unsigned NOT NULL,
  `source` int(11) NOT NULL DEFAULT '0',
  `object` int(11) NOT NULL DEFAULT '0',
  `objectid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `acknowledged` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`eventid`),
  KEY `events_1` (`source`,`object`,`objectid`,`clock`),
  KEY `events_2` (`source`,`object`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expressions`
--

DROP TABLE IF EXISTS `expressions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expressions` (
  `expressionid` bigint(20) unsigned NOT NULL,
  `regexpid` bigint(20) unsigned NOT NULL,
  `expression` varchar(255) NOT NULL DEFAULT '',
  `expression_type` int(11) NOT NULL DEFAULT '0',
  `exp_delimiter` varchar(1) NOT NULL DEFAULT '',
  `case_sensitive` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`expressionid`),
  KEY `expressions_1` (`regexpid`),
  CONSTRAINT `c_expressions_1` FOREIGN KEY (`regexpid`) REFERENCES `regexps` (`regexpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expressions`
--

LOCK TABLES `expressions` WRITE;
/*!40000 ALTER TABLE `expressions` DISABLE KEYS */;
INSERT INTO `expressions` VALUES (1,1,'^(btrfs|ext2|ext3|ext4|jfs|reiser|xfs|ffs|ufs|jfs|jfs2|vxfs|hfs|ntfs|fat32|zfs)$',3,',',0),(2,2,'^lo$',4,',',1),(3,3,'^(Physical memory|Virtual memory|Memory buffers|Cached memory|Swap space)$',4,',',1),(4,2,'^Software Loopback Interface',4,',',1);
/*!40000 ALTER TABLE `expressions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functions` (
  `functionid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `function` varchar(12) NOT NULL DEFAULT '',
  `parameter` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`functionid`),
  KEY `functions_1` (`triggerid`),
  KEY `functions_2` (`itemid`,`function`,`parameter`),
  CONSTRAINT `c_functions_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_functions_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
INSERT INTO `functions` VALUES (10199,10019,10016,'diff','0'),(10204,10055,10041,'last','0'),(10207,10058,10044,'diff','0'),(10208,10057,10043,'diff','0'),(12144,22181,13000,'last','0'),(12549,22232,13025,'nodata','5m'),(12550,10020,10047,'nodata','5m'),(12553,10056,10042,'last','0'),(12580,17350,10012,'last','0'),(12583,10025,10021,'change','0'),(12592,22686,13266,'last','0'),(12598,22454,13272,'last','0'),(12641,22189,13015,'min','10m'),(12645,22183,13073,'min','10m'),(12646,22191,13074,'min','10m'),(12648,23620,13075,'min','10m'),(12649,22185,13019,'min','10m'),(12651,22396,13017,'min','10m'),(12653,22219,13023,'min','10m'),(12671,22704,13287,'diff','0'),(12672,22726,13288,'diff','0'),(12673,22741,13289,'diff','0'),(12675,22757,13291,'last','0'),(12676,22756,13291,'last','0'),(12677,22766,13292,'last','0'),(12678,22764,13292,'last','0'),(12679,22773,13293,'last','0'),(12680,22771,13293,'last','0'),(12681,22785,13294,'diff','0'),(12682,22808,13295,'last','0'),(12683,22808,13296,'last','0'),(12684,22809,13297,'last','0'),(12685,22809,13298,'last','0'),(12686,22810,13299,'last','0'),(12687,22810,13300,'last','0'),(12688,22811,13301,'last','0'),(12689,22811,13302,'last','0'),(12690,22800,13303,'last','0'),(12691,22800,13304,'last','0'),(12692,22801,13305,'last','0'),(12693,22812,13306,'last','0'),(12694,22801,13307,'last','0'),(12695,22812,13308,'last','0'),(12696,22802,13309,'last','0'),(12697,22813,13310,'last','0'),(12698,22802,13311,'last','0'),(12699,22813,13312,'last','0'),(12700,22814,13313,'last','0'),(12701,22803,13314,'last','0'),(12702,22814,13315,'last','0'),(12703,22803,13316,'last','0'),(12704,22804,13317,'last','0'),(12705,22804,13318,'last','0'),(12706,22815,13319,'last','0'),(12707,22815,13320,'last','0'),(12708,22816,13321,'last','0'),(12709,22805,13322,'last','0'),(12710,22817,13323,'last','0'),(12711,22817,13324,'last','0'),(12712,22818,13325,'last','0'),(12713,22818,13326,'last','0'),(12715,22833,13328,'nodata','5m'),(12717,22835,13330,'last','0'),(12718,22836,13331,'last','0'),(12723,22853,13336,'diff','0'),(12724,22856,13337,'last','0'),(12725,22858,13338,'diff','0'),(12726,22859,13339,'change','0'),(12727,22861,13340,'diff','0'),(12728,22862,13341,'last','0'),(12729,22869,13342,'last','0'),(12730,22872,13343,'last','0'),(12731,22873,13344,'nodata','5m'),(12733,22875,13346,'last','0'),(12734,22876,13347,'last','0'),(12739,22893,13352,'diff','0'),(12740,22896,13353,'last','0'),(12741,22898,13354,'diff','0'),(12742,22899,13355,'change','0'),(12743,22901,13356,'diff','0'),(12744,22902,13357,'last','0'),(12745,22909,13358,'last','0'),(12746,22912,13359,'last','0'),(12747,22913,13360,'nodata','5m'),(12755,22933,13368,'diff','0'),(12757,22938,13370,'diff','0'),(12758,22939,13371,'change','0'),(12759,22941,13372,'diff','0'),(12760,22942,13373,'last','0'),(12761,22949,13374,'last','0'),(12762,22952,13375,'last','0'),(12763,22953,13376,'nodata','5m'),(12771,22973,13384,'diff','0'),(12773,22978,13386,'diff','0'),(12775,22981,13388,'diff','0'),(12776,22982,13389,'last','0'),(12777,22989,13390,'last','0'),(12778,22992,13391,'last','0'),(12779,22993,13392,'nodata','5m'),(12782,22996,13395,'last','0'),(12787,23013,13400,'diff','0'),(12788,23016,13401,'last','0'),(12789,23018,13402,'diff','0'),(12790,23019,13403,'change','0'),(12791,23021,13404,'diff','0'),(12792,23022,13405,'last','0'),(12793,23029,13406,'last','0'),(12794,23032,13407,'last','0'),(12795,23033,13408,'nodata','5m'),(12797,23035,13410,'last','0'),(12798,23036,13411,'last','0'),(12803,23053,13416,'diff','0'),(12805,23058,13418,'diff','0'),(12806,23059,13419,'change','0'),(12807,23061,13420,'diff','0'),(12808,23062,13421,'last','0'),(12809,23069,13422,'last','0'),(12810,23072,13423,'last','0'),(12812,23149,13425,'diff','0'),(12815,23150,13428,'change','0'),(12818,23147,13431,'last','0'),(12820,23158,13433,'last','0'),(12824,23160,13437,'nodata','5m'),(12826,23165,13439,'last','0'),(12830,23226,13442,'last','0'),(12831,23227,13442,'last','0'),(12832,23235,13443,'last','0'),(12833,23236,13443,'last','0'),(12834,23243,13444,'last','0'),(12835,23244,13444,'last','0'),(12836,23193,13445,'last','0'),(12837,23192,13445,'last','0'),(12838,23196,13446,'last','0'),(12839,23195,13446,'last','0'),(12840,23199,13447,'last','0'),(12841,23198,13447,'last','0'),(12842,23202,13448,'last','0'),(12843,23201,13448,'last','0'),(12844,23205,13449,'last','0'),(12845,23204,13449,'last','0'),(12846,23208,13450,'last','0'),(12847,23207,13450,'last','0'),(12848,23211,13451,'last','0'),(12849,23210,13451,'last','0'),(12850,23214,13452,'last','0'),(12851,23213,13452,'last','0'),(12852,23183,13453,'last','0'),(12853,23177,13453,'last','0'),(12854,23179,13454,'last','0'),(12855,23181,13454,'last','0'),(12856,23186,13455,'last','0'),(12857,23187,13455,'last','0'),(12858,23222,13456,'str','off'),(12859,23231,13457,'str','off'),(12860,23191,13458,'last','0'),(12861,23192,13458,'last','0'),(12862,23194,13459,'last','0'),(12863,23195,13459,'last','0'),(12864,23197,13460,'last','0'),(12865,23198,13460,'last','0'),(12866,23200,13461,'last','0'),(12867,23201,13461,'last','0'),(12868,23203,13462,'last','0'),(12869,23204,13462,'last','0'),(12870,23206,13463,'last','0'),(12871,23207,13463,'last','0'),(12872,23209,13464,'last','0'),(12873,23210,13464,'last','0'),(12874,23188,13465,'nodata','1m'),(12895,23271,13486,'min','10m'),(12896,23273,13487,'min','10m'),(12897,23274,13488,'min','10m'),(12898,23275,13489,'min','10m'),(12899,23276,13490,'min','10m'),(12900,23287,13491,'nodata','5m'),(12902,23289,13493,'last','0'),(12903,23290,13494,'last','0'),(12908,23307,13499,'diff','0'),(12909,23310,13500,'last','0'),(12910,23312,13501,'diff','0'),(12911,23313,13502,'change','0'),(12912,23315,13503,'diff','0'),(12913,23316,13504,'last','0'),(12914,23282,13505,'last','0'),(12915,23284,13506,'last','0'),(12926,22231,13026,'diff','0'),(12927,10059,10045,'diff','0'),(12928,23288,13492,'diff','0'),(12929,22834,13329,'diff','0'),(12930,22874,13345,'diff','0'),(12931,22914,13361,'diff','0'),(12932,22954,13377,'diff','0'),(12933,22994,13393,'diff','0'),(12934,23034,13409,'diff','0'),(12935,23161,13438,'diff','0'),(12936,23318,13507,'diff','0'),(12937,23319,13508,'diff','0'),(12938,23327,13509,'diff','0'),(12939,23320,13510,'diff','0'),(12940,23321,13511,'diff','0'),(12941,23322,13512,'diff','0'),(12942,23323,13513,'diff','0'),(12943,23324,13514,'diff','0'),(12944,23325,13515,'diff','0'),(12945,23326,13516,'diff','0'),(12946,23357,13517,'min','10m'),(12947,23342,13518,'min','10m'),(12948,23341,13519,'min','10m'),(12949,23359,13520,'min','10m'),(12965,23634,13536,'min','10m'),(12966,23635,13537,'min','10m'),(12967,23212,13466,'str','Client'),(12968,23637,13538,'last','0'),(12969,23638,13539,'last','0'),(12970,23640,13539,'last','0'),(12971,23642,13540,'last','0'),(12972,23643,13540,'last','0'),(12973,23639,13541,'last','0'),(12974,23640,13541,'last','0'),(12975,23641,13542,'last','0'),(12976,23643,13542,'last','0'),(12977,23636,13543,'str','Server'),(12994,23644,13544,'max','#3'),(12995,23645,13545,'max','#3'),(12996,23646,13546,'max','#3'),(12997,23647,13547,'max','#3'),(12998,23648,13548,'max','#3'),(13029,22414,13093,'min','10m'),(13030,23266,13481,'min','10m'),(13068,23115,13367,'avg','5m'),(13069,22922,13366,'avg','5m'),(13070,22918,13365,'avg','5m'),(13071,22917,13364,'avg','5m'),(13072,22882,13350,'avg','5m'),(13073,22878,13349,'avg','5m'),(13074,22877,13348,'avg','5m'),(13075,22962,13382,'avg','5m'),(13078,10010,10010,'avg','5m'),(13079,23296,13497,'avg','5m'),(13080,17362,13243,'avg','5m'),(13081,23301,13498,'avg','5m'),(13082,10009,10190,'avg','5m'),(13083,23292,13496,'avg','5m'),(13084,10013,10011,'avg','5m'),(13085,23291,13495,'avg','5m'),(13086,23042,13414,'avg','5m'),(13087,22842,13334,'avg','5m'),(13088,22838,13333,'avg','5m'),(13089,22837,13332,'avg','5m'),(13090,23007,13399,'avg','5m'),(13091,23002,13398,'avg','5m'),(13092,22998,13397,'avg','5m'),(13093,22997,13396,'avg','5m'),(13094,23143,13435,'avg','5m'),(13095,23140,13430,'avg','5m'),(13096,23655,13554,'max','#3'),(13097,23656,13555,'avg','5m'),(13098,23657,13556,'min','5m'),(13099,22424,13080,'avg','10m'),(13100,23252,13467,'avg','10m'),(13101,22412,13081,'avg','10m'),(13102,23253,13468,'avg','10m'),(13103,22410,13082,'avg','10m'),(13104,23254,13469,'avg','10m'),(13105,22430,13083,'avg','10m'),(13106,23255,13470,'avg','10m'),(13107,22422,13084,'avg','10m'),(13108,23256,13471,'avg','10m'),(13109,22406,13085,'avg','10m'),(13110,23257,13472,'avg','10m'),(13111,22408,13086,'avg','30m'),(13112,23258,13473,'avg','30m'),(13113,22402,13087,'avg','10m'),(13114,23259,13474,'avg','10m'),(13115,22418,13088,'avg','10m'),(13116,23260,13475,'avg','10m'),(13117,22416,13089,'avg','10m'),(13118,23261,13476,'avg','10m'),(13119,22689,13275,'avg','10m'),(13120,23262,13477,'avg','10m'),(13121,22428,13090,'avg','10m'),(13122,23263,13478,'avg','10m'),(13123,22399,13091,'avg','10m'),(13124,23264,13479,'avg','10m'),(13125,22420,13092,'avg','10m'),(13126,23265,13480,'avg','10m'),(13127,23171,13441,'avg','10m'),(13128,23267,13482,'avg','10m'),(13129,22426,13094,'avg','10m'),(13130,23268,13483,'avg','10m'),(13131,22404,13095,'avg','10m'),(13132,23269,13484,'avg','10m'),(13133,22400,13096,'avg','10m'),(13134,23270,13485,'avg','10m'),(13135,22401,13097,'avg','10m'),(13136,23328,13436,'avg','10m'),(13137,23347,13521,'avg','10m'),(13138,23360,13534,'avg','10m'),(13139,23352,13522,'avg','10m'),(13140,23351,13535,'avg','10m'),(13141,23350,13523,'avg','10m'),(13142,23353,13524,'avg','30m'),(13143,23354,13525,'avg','10m'),(13144,23356,13526,'avg','10m'),(13145,23355,13527,'avg','10m'),(13146,23349,13528,'avg','10m'),(13147,23348,13529,'avg','10m'),(13148,23343,13530,'avg','10m'),(13149,23344,13531,'avg','10m'),(13150,23345,13532,'avg','10m'),(13151,23346,13533,'avg','10m'),(13152,23651,13551,'max','#3'),(13154,23649,13549,'max','#3'),(13155,22819,13327,'last','0'),(13156,23650,13550,'max','#3'),(13157,23652,13552,'max','#3'),(13158,23653,13553,'max','#3'),(13159,23654,13285,'max','#3');
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalmacro`
--

DROP TABLE IF EXISTS `globalmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalmacro` (
  `globalmacroid` bigint(20) unsigned NOT NULL,
  `macro` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`globalmacroid`),
  KEY `globalmacro_1` (`macro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalmacro`
--

LOCK TABLES `globalmacro` WRITE;
/*!40000 ALTER TABLE `globalmacro` DISABLE KEYS */;
INSERT INTO `globalmacro` VALUES (2,'{$SNMP_COMMUNITY}','public');
/*!40000 ALTER TABLE `globalmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalvars`
--

DROP TABLE IF EXISTS `globalvars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalvars` (
  `globalvarid` bigint(20) unsigned NOT NULL,
  `snmp_lastsize` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`globalvarid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalvars`
--

LOCK TABLES `globalvars` WRITE;
/*!40000 ALTER TABLE `globalvars` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalvars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_discovery`
--

DROP TABLE IF EXISTS `graph_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_discovery` (
  `graphdiscoveryid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `parent_graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`graphdiscoveryid`),
  UNIQUE KEY `graph_discovery_1` (`graphid`,`parent_graphid`),
  KEY `graph_discovery_2` (`parent_graphid`),
  CONSTRAINT `c_graph_discovery_2` FOREIGN KEY (`parent_graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graph_discovery_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_discovery`
--

LOCK TABLES `graph_discovery` WRITE;
/*!40000 ALTER TABLE `graph_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `graph_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graph_theme`
--

DROP TABLE IF EXISTS `graph_theme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graph_theme` (
  `graphthemeid` bigint(20) unsigned NOT NULL,
  `description` varchar(64) NOT NULL DEFAULT '',
  `theme` varchar(64) NOT NULL DEFAULT '',
  `backgroundcolor` varchar(6) NOT NULL DEFAULT 'F0F0F0',
  `graphcolor` varchar(6) NOT NULL DEFAULT 'FFFFFF',
  `graphbordercolor` varchar(6) NOT NULL DEFAULT '222222',
  `gridcolor` varchar(6) NOT NULL DEFAULT 'CCCCCC',
  `maingridcolor` varchar(6) NOT NULL DEFAULT 'AAAAAA',
  `gridbordercolor` varchar(6) NOT NULL DEFAULT '000000',
  `textcolor` varchar(6) NOT NULL DEFAULT '202020',
  `highlightcolor` varchar(6) NOT NULL DEFAULT 'AA4444',
  `leftpercentilecolor` varchar(6) NOT NULL DEFAULT '11CC11',
  `rightpercentilecolor` varchar(6) NOT NULL DEFAULT 'CC1111',
  `nonworktimecolor` varchar(6) NOT NULL DEFAULT 'CCCCCC',
  `gridview` int(11) NOT NULL DEFAULT '1',
  `legendview` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`graphthemeid`),
  KEY `graph_theme_1` (`description`),
  KEY `graph_theme_2` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graph_theme`
--

LOCK TABLES `graph_theme` WRITE;
/*!40000 ALTER TABLE `graph_theme` DISABLE KEYS */;
INSERT INTO `graph_theme` VALUES (1,'Original Blue','originalblue','F0F0F0','FFFFFF','333333','CCCCCC','AAAAAA','000000','222222','AA4444','11CC11','CC1111','E0E0E0',1,1),(2,'Black & Blue','darkblue','333333','0A0A0A','888888','222222','4F4F4F','EFEFEF','0088FF','CC4444','1111FF','FF1111','1F1F1F',1,1),(3,'Dark orange','darkorange','333333','0A0A0A','888888','222222','4F4F4F','EFEFEF','DFDFDF','FF5500','FF5500','FF1111','1F1F1F',1,1),(4,'Classic','classic','F0F0F0','FFFFFF','333333','CCCCCC','AAAAAA','000000','222222','AA4444','11CC11','CC1111','E0E0E0',1,1);
/*!40000 ALTER TABLE `graph_theme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs`
--

DROP TABLE IF EXISTS `graphs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs` (
  `graphid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '900',
  `height` int(11) NOT NULL DEFAULT '200',
  `yaxismin` double(16,4) NOT NULL DEFAULT '0.0000',
  `yaxismax` double(16,4) NOT NULL DEFAULT '100.0000',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `show_work_period` int(11) NOT NULL DEFAULT '1',
  `show_triggers` int(11) NOT NULL DEFAULT '1',
  `graphtype` int(11) NOT NULL DEFAULT '0',
  `show_legend` int(11) NOT NULL DEFAULT '1',
  `show_3d` int(11) NOT NULL DEFAULT '0',
  `percent_left` double(16,4) NOT NULL DEFAULT '0.0000',
  `percent_right` double(16,4) NOT NULL DEFAULT '0.0000',
  `ymin_type` int(11) NOT NULL DEFAULT '0',
  `ymax_type` int(11) NOT NULL DEFAULT '0',
  `ymin_itemid` bigint(20) unsigned DEFAULT NULL,
  `ymax_itemid` bigint(20) unsigned DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`graphid`),
  KEY `graphs_1` (`name`),
  KEY `graphs_2` (`templateid`),
  KEY `graphs_3` (`ymin_itemid`),
  KEY `graphs_4` (`ymax_itemid`),
  CONSTRAINT `c_graphs_3` FOREIGN KEY (`ymax_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_graphs_1` FOREIGN KEY (`templateid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_2` FOREIGN KEY (`ymin_itemid`) REFERENCES `items` (`itemid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs`
--

LOCK TABLES `graphs` WRITE;
/*!40000 ALTER TABLE `graphs` DISABLE KEYS */;
INSERT INTO `graphs` VALUES (387,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(392,'Zabbix server performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(404,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(406,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(410,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(420,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(433,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(436,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(439,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(442,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(445,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(446,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,445,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(447,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,445,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(449,'Traffic on interface {#SNMPVALUE}',900,200,0.0000,100.0000,445,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,2),(450,'Fan speed and ambient temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(451,'Fan speed and temperature',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(452,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(453,'Voltage',900,200,0.0000,5.5000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(454,'MySQL operations',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(455,'MySQL bandwidth',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(456,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(457,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(458,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(459,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(461,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(462,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(463,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(464,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(465,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(467,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(469,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(471,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(472,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(473,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(474,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(475,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(478,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(479,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(480,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(481,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(482,'Swap usage',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(483,'CPU jumps',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(484,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(485,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(487,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(491,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(492,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(493,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(494,'Network traffic on en0',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(495,'CPU load',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(496,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(497,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(498,'CPU utilization',900,200,0.0000,100.0000,NULL,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(499,'Class Loader',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(500,'File Descriptors',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(501,'Garbage Collector collections per second',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(502,'http-8080 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(503,'http-8443 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(504,'jk-8009 worker threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(505,'Memory Pool CMS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(506,'Memory Pool CMS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(507,'Memory Pool Code Cache',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(508,'Memory Pool Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(509,'Memory Pool PS Old Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(510,'Memory Pool PS Perm Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(511,'Memory Pool Tenured Gen',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(512,'sessions /',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(513,'Threads',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(514,'Disk space usage {#SNMPVALUE}',600,340,0.0000,100.0000,NULL,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(515,'Disk space usage {#SNMPVALUE}',600,340,0.0000,100.0000,514,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(516,'Disk space usage {#SNMPVALUE}',600,340,0.0000,100.0000,514,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(517,'Zabbix internal process busy %',900,200,0.0000,100.0000,406,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(518,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,404,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(519,'Zabbix server performance',900,200,0.0000,100.0000,392,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(520,'Zabbix cache usage, % free',900,200,0.0000,100.0000,410,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(521,'Network traffic on {#IFNAME}',900,200,0.0000,100.0000,420,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,2),(522,'Disk space usage {#FSNAME}',600,340,0.0000,100.0000,442,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,2),(523,'CPU jumps',900,200,0.0000,100.0000,439,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(524,'CPU load',900,200,0.0000,100.0000,433,1,1,0,1,0,0.0000,0.0000,1,0,NULL,NULL,0),(525,'CPU utilization',900,200,0.0000,100.0000,387,1,0,1,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(526,'Swap usage',600,340,0.0000,100.0000,436,0,0,2,1,1,0.0000,0.0000,0,0,NULL,NULL,0),(527,'Value cache effectiveness',900,200,0.0000,100.0000,NULL,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(528,'Value cache effectiveness',900,200,0.0000,100.0000,527,1,1,1,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(529,'Zabbix cache usage, % free',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(530,'Zabbix data gathering process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(531,'Zabbix internal process busy %',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,1,NULL,NULL,0),(532,'Zabbix proxy performance',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,0,0,NULL,NULL,0),(533,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,10026,0),(534,'Memory usage',900,200,0.0000,100.0000,533,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23317,0),(540,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22943,0),(541,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22903,0),(542,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22983,0),(543,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23063,0),(544,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,22863,0),(545,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23023,0),(546,'Memory usage',900,200,0.0000,100.0000,NULL,1,1,0,1,0,0.0000,0.0000,1,2,NULL,23159,0);
/*!40000 ALTER TABLE `graphs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graphs_items`
--

DROP TABLE IF EXISTS `graphs_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `graphs_items` (
  `gitemid` bigint(20) unsigned NOT NULL,
  `graphid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '009600',
  `yaxisside` int(11) NOT NULL DEFAULT '0',
  `calc_fnc` int(11) NOT NULL DEFAULT '2',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gitemid`),
  KEY `graphs_items_1` (`itemid`),
  KEY `graphs_items_2` (`graphid`),
  CONSTRAINT `c_graphs_items_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_graphs_items_1` FOREIGN KEY (`graphid`) REFERENCES `graphs` (`graphid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graphs_items`
--

LOCK TABLES `graphs_items` WRITE;
/*!40000 ALTER TABLE `graphs_items` DISABLE KEYS */;
INSERT INTO `graphs_items` VALUES (1242,387,22665,1,0,'FF5555',0,2,0),(1243,387,22668,1,1,'55FF55',0,2,0),(1244,387,22671,1,2,'009999',0,2,0),(1245,387,17358,1,3,'990099',0,2,0),(1246,387,17362,1,4,'999900',0,2,0),(1247,387,17360,1,5,'990000',0,2,0),(1248,387,17356,1,6,'000099',0,2,0),(1249,387,17354,1,7,'009900',0,2,0),(1290,439,22680,0,0,'009900',0,2,0),(1291,439,22683,0,1,'000099',0,2,0),(1296,433,10010,0,0,'009900',0,2,0),(1297,433,22674,0,1,'000099',0,2,0),(1298,433,22677,0,2,'990000',0,2,0),(1323,436,10030,0,0,'AA0000',0,2,2),(1324,436,10014,0,1,'00AA00',0,2,0),(1353,420,22446,5,0,'00AA00',0,2,0),(1354,420,22448,5,1,'3333FF',0,2,0),(1411,406,22426,0,0,'00EE00',0,2,0),(1412,406,22428,0,1,'007777',0,2,0),(1413,406,22422,0,2,'0000EE',0,2,0),(1414,406,22408,0,3,'FFAA00',0,2,0),(1415,406,22424,0,4,'00EEEE',0,2,0),(1416,406,22412,0,5,'990099',0,2,0),(1417,406,22410,0,6,'666600',0,2,0),(1418,406,22406,0,7,'EE0000',0,2,0),(1419,406,22414,0,8,'FF66FF',0,2,0),(1429,410,22185,0,0,'009900',0,2,0),(1430,410,22189,0,1,'DD0000',0,2,0),(1431,410,22396,0,2,'00DDDD',0,2,0),(1432,410,22183,0,3,'3333FF',0,2,0),(1441,392,22187,5,0,'00C800',0,2,0),(1442,392,23251,5,1,'C80000',1,2,0),(1451,445,22701,5,0,'00AA00',0,2,0),(1452,445,22702,5,1,'3333FF',0,2,0),(1453,446,22725,5,0,'00AA00',0,2,0),(1454,446,22728,5,1,'3333FF',0,2,0),(1455,447,22740,5,0,'00AA00',0,2,0),(1456,447,22743,5,1,'3333FF',0,2,0),(1457,449,22784,5,0,'00AA00',0,2,0),(1458,449,22787,5,1,'3333FF',0,2,0),(1459,442,22456,0,0,'C80000',0,2,2),(1460,442,22452,0,1,'00C800',0,2,0),(1461,450,22804,5,0,'EE0000',0,2,0),(1462,450,22807,0,1,'000000',1,2,0),(1463,451,22808,2,1,'EE00EE',0,2,0),(1464,451,22815,2,0,'EE0000',0,2,0),(1465,451,22818,4,3,'000000',1,2,0),(1466,451,22817,0,2,'000000',1,2,0),(1467,452,22803,0,4,'3333FF',0,2,0),(1468,452,22800,0,1,'009900',0,2,0),(1469,452,22801,0,2,'00CCCC',0,2,0),(1470,452,22802,0,3,'000000',0,2,0),(1471,452,22805,2,0,'880000',0,2,0),(1472,452,22806,0,5,'777700',0,2,0),(1473,453,22809,0,1,'009900',0,2,0),(1474,453,22816,2,0,'880000',0,2,0),(1475,453,22813,0,3,'000000',0,2,0),(1476,453,22814,0,4,'3333FF',0,2,0),(1477,453,22812,0,2,'00CCCC',0,2,0),(1478,454,22827,0,0,'C8C800',0,2,0),(1479,454,22826,0,1,'006400',0,2,0),(1480,454,22828,0,2,'C80000',0,2,0),(1481,454,22822,0,3,'0000EE',0,2,0),(1482,454,22825,0,4,'640000',0,2,0),(1483,454,22823,0,5,'00C800',0,2,0),(1484,454,22824,0,6,'C800C8',0,2,0),(1487,455,22830,5,0,'00AA00',0,2,0),(1488,455,22829,5,1,'3333FF',0,2,0),(1491,456,22846,1,0,'009999',0,2,0),(1492,456,22848,1,1,'990099',0,2,0),(1494,456,22851,1,2,'990000',0,2,0),(1495,456,22852,1,3,'000099',0,2,0),(1496,456,22845,1,4,'009900',0,2,0),(1497,457,22842,0,0,'009900',0,2,0),(1498,457,22843,0,1,'000099',0,2,0),(1499,457,22841,0,2,'990000',0,2,0),(1500,458,22857,0,0,'AA0000',0,2,2),(1501,458,22855,0,1,'00AA00',0,2,0),(1502,459,22844,0,0,'009900',0,2,0),(1503,459,22840,0,1,'000099',0,2,0),(1506,461,22870,0,0,'C80000',0,2,2),(1507,461,22868,0,1,'00C800',0,2,0),(1510,462,22886,1,0,'009999',0,2,0),(1511,462,22888,1,1,'990099',0,2,0),(1513,462,22891,1,2,'990000',0,2,0),(1514,462,22892,1,3,'000099',0,2,0),(1515,462,22885,1,4,'009900',0,2,0),(1516,463,22882,0,0,'009900',0,2,0),(1517,463,22883,0,1,'000099',0,2,0),(1518,463,22881,0,2,'990000',0,2,0),(1519,464,22897,0,0,'AA0000',0,2,2),(1520,464,22895,0,1,'00AA00',0,2,0),(1521,465,22884,0,0,'009900',0,2,0),(1522,465,22880,0,1,'000099',0,2,0),(1525,467,22910,0,0,'C80000',0,2,2),(1526,467,22908,0,1,'00C800',0,2,0),(1535,469,22922,0,0,'009900',0,2,0),(1536,469,22923,0,1,'000099',0,2,0),(1537,469,22921,0,2,'990000',0,2,0),(1540,471,22924,0,0,'009900',0,2,0),(1541,471,22920,0,1,'000099',0,2,0),(1542,472,22945,5,0,'00AA00',0,2,0),(1543,472,22946,5,1,'3333FF',0,2,0),(1544,473,22950,0,0,'C80000',0,2,2),(1545,473,22948,0,1,'00C800',0,2,0),(1549,474,22968,1,0,'990099',0,2,0),(1551,474,22971,1,1,'990000',0,2,0),(1552,474,22972,1,2,'000099',0,2,0),(1553,474,22965,1,3,'009900',0,2,0),(1554,475,22962,0,0,'009900',0,2,0),(1555,475,22963,0,1,'000099',0,2,0),(1556,475,22961,0,2,'990000',0,2,0),(1561,478,22985,5,0,'00AA00',0,2,0),(1562,478,22986,5,1,'3333FF',0,2,0),(1563,479,22990,0,0,'C80000',0,2,2),(1564,479,22988,0,1,'00C800',0,2,0),(1569,480,23007,1,0,'999900',0,2,0),(1570,480,23011,1,1,'990000',0,2,0),(1571,480,23012,1,2,'000099',0,2,0),(1572,480,23005,1,3,'009900',0,2,0),(1573,481,23002,0,0,'009900',0,2,0),(1574,481,23003,0,1,'000099',0,2,0),(1575,481,23001,0,2,'990000',0,2,0),(1576,482,23017,0,0,'AA0000',0,2,2),(1577,482,23015,0,1,'00AA00',0,2,0),(1578,483,23004,0,0,'009900',0,2,0),(1579,483,23000,0,1,'000099',0,2,0),(1580,484,23025,5,0,'00AA00',0,2,0),(1581,484,23026,5,1,'3333FF',0,2,0),(1582,485,23030,0,0,'C80000',0,2,2),(1583,485,23028,0,1,'00C800',0,2,0),(1592,487,23042,0,0,'009900',0,2,0),(1593,487,23043,0,1,'000099',0,2,0),(1594,487,23041,0,2,'990000',0,2,0),(1601,491,23070,0,0,'C80000',0,2,2),(1602,491,23068,0,1,'00C800',0,2,0),(1603,492,23073,5,0,'00AA00',0,2,0),(1604,492,23074,5,1,'3333FF',0,2,0),(1607,493,23075,5,0,'00AA00',0,2,0),(1608,493,23076,5,1,'3333FF',0,2,0),(1610,404,22401,0,10,'00FF00',0,2,0),(1611,494,23077,5,0,'00AA00',0,2,0),(1612,494,23078,5,1,'3333FF',0,2,0),(1613,495,23143,0,0,'009900',0,2,0),(1614,495,23145,0,1,'000099',0,2,0),(1615,495,23144,0,2,'990000',0,2,0),(1616,496,23167,0,0,'C80000',0,2,2),(1617,496,23164,0,1,'00C800',0,2,0),(1618,497,23169,5,0,'00AA00',0,2,0),(1619,497,23170,5,1,'3333FF',0,2,0),(1620,498,23109,0,0,'009999',0,2,0),(1621,498,23112,0,1,'990099',0,2,0),(1622,498,23115,0,2,'999900',0,2,0),(1623,498,23113,0,3,'990000',0,2,0),(1624,498,23114,0,4,'000099',0,2,0),(1625,498,23110,0,5,'009900',0,2,0),(1626,404,22404,0,0,'990099',0,2,0),(1627,404,22399,0,1,'990000',0,2,0),(1628,404,22416,0,2,'0000EE',0,2,0),(1629,404,22430,0,3,'FF33FF',0,2,0),(1630,404,22418,0,4,'009600',0,2,0),(1631,404,22402,0,5,'003300',0,2,0),(1632,404,22420,0,6,'CCCC00',0,2,0),(1633,404,22400,0,7,'33FFFF',0,2,0),(1634,404,22689,0,8,'DD0000',0,2,0),(1635,404,23171,0,9,'000099',0,2,0),(1636,499,23174,0,0,'C80000',0,2,0),(1637,499,23175,0,1,'00C800',0,2,0),(1638,499,23173,0,2,'0000C8',0,2,0),(1639,500,23213,0,0,'C80000',0,2,0),(1640,500,23214,0,1,'00C800',0,2,0),(1641,501,23186,0,0,'C80000',0,2,0),(1642,501,23177,0,1,'00C800',0,2,0),(1643,501,23179,0,2,'0000C8',0,2,0),(1644,501,23181,0,3,'C8C800',0,2,0),(1645,501,23187,0,4,'00C8C9',0,2,0),(1646,501,23183,0,5,'C800C8',0,2,0),(1647,502,23227,0,0,'C80000',0,2,0),(1648,502,23226,0,1,'00C800',0,2,0),(1649,502,23225,0,2,'0000C8',0,2,0),(1650,503,23236,0,0,'C80000',0,2,0),(1651,503,23235,0,1,'00C800',0,2,0),(1652,503,23234,0,2,'0000C8',0,2,0),(1653,504,23244,0,0,'C80000',0,2,0),(1654,504,23243,0,1,'00C800',0,2,0),(1655,504,23242,0,2,'0000C8',0,2,0),(1656,505,23191,0,0,'C80000',0,2,0),(1657,505,23192,0,1,'00C800',0,2,0),(1658,505,23193,0,2,'0000C8',0,2,0),(1659,506,23194,0,0,'C80000',0,2,0),(1660,506,23195,0,1,'00C800',0,2,0),(1661,506,23196,0,2,'0000C8',0,2,0),(1662,507,23197,0,0,'C80000',0,2,0),(1663,507,23198,0,1,'00C800',0,2,0),(1664,507,23199,0,2,'0000C8',0,2,0),(1665,508,23200,0,0,'C80000',0,2,0),(1666,508,23201,0,1,'00C800',0,2,0),(1667,508,23202,0,2,'0000C8',0,2,0),(1668,509,23203,0,0,'C80000',0,2,0),(1669,509,23204,0,1,'00C800',0,2,0),(1670,509,23205,0,2,'0000C8',0,2,0),(1671,510,23206,0,0,'0000C8',0,2,0),(1672,510,23207,0,1,'C80000',0,2,0),(1673,510,23208,0,2,'00C800',0,2,0),(1674,511,23209,0,0,'C80000',0,2,0),(1675,511,23210,0,1,'00C800',0,2,0),(1676,511,23211,0,2,'0000C8',0,2,0),(1677,512,23248,0,0,'C80000',0,2,0),(1678,512,23246,0,1,'00C800',0,2,0),(1679,512,23249,0,2,'0000C8',0,2,0),(1680,513,23216,0,0,'C80000',0,2,0),(1681,513,23215,0,1,'00C800',0,2,0),(1682,513,23217,0,2,'0000C8',0,2,0),(1683,514,22758,0,0,'00C800',0,2,2),(1684,514,22759,0,1,'C80000',0,2,0),(1685,515,22763,0,0,'00C800',0,2,2),(1686,515,22765,0,1,'C80000',0,2,0),(1687,516,22770,0,0,'00C800',0,2,2),(1688,516,22772,0,1,'C80000',0,2,0),(1689,517,23268,0,0,'00EE00',0,2,0),(1690,517,23263,0,1,'007777',0,2,0),(1691,517,23256,0,2,'0000EE',0,2,0),(1692,517,23258,0,3,'FFAA00',0,2,0),(1693,517,23252,0,4,'00EEEE',0,2,0),(1694,517,23253,0,5,'990099',0,2,0),(1695,517,23254,0,6,'666600',0,2,0),(1696,517,23257,0,7,'EE0000',0,2,0),(1697,517,23266,0,8,'FF66FF',0,2,0),(1698,518,23269,0,0,'990099',0,2,0),(1699,518,23264,0,1,'990000',0,2,0),(1700,518,23261,0,2,'0000EE',0,2,0),(1701,518,23255,0,3,'FF33FF',0,2,0),(1702,518,23260,0,4,'009600',0,2,0),(1703,518,23259,0,5,'003300',0,2,0),(1704,518,23265,0,6,'CCCC00',0,2,0),(1705,518,23270,0,7,'33FFFF',0,2,0),(1706,518,23262,0,8,'DD0000',0,2,0),(1707,518,23267,0,9,'000099',0,2,0),(1708,519,23277,5,0,'00C800',0,2,0),(1709,519,23272,5,1,'C80000',1,2,0),(1710,518,23328,0,10,'00FF00',0,2,0),(1714,521,23280,5,0,'00AA00',0,2,0),(1715,521,23281,5,1,'3333FF',0,2,0),(1716,522,23285,0,0,'C80000',0,2,2),(1717,522,23283,0,1,'00C800',0,2,0),(1718,523,23298,0,0,'009900',0,2,0),(1719,523,23294,0,1,'000099',0,2,0),(1720,524,23296,0,0,'009900',0,2,0),(1721,524,23297,0,1,'000099',0,2,0),(1722,524,23295,0,2,'990000',0,2,0),(1723,525,23304,1,0,'FF5555',0,2,0),(1724,525,23303,1,1,'55FF55',0,2,0),(1725,525,23300,1,2,'009999',0,2,0),(1726,525,23302,1,3,'990099',0,2,0),(1727,525,23301,1,4,'999900',0,2,0),(1728,525,23305,1,5,'990000',0,2,0),(1729,525,23306,1,6,'000099',0,2,0),(1730,525,23299,1,7,'009900',0,2,0),(1731,526,23311,0,0,'AA0000',0,2,2),(1732,526,23309,0,1,'00AA00',0,2,0),(1733,410,22191,0,4,'999900',0,2,0),(1735,527,22199,0,0,'C80000',0,2,0),(1736,527,22196,0,1,'00C800',0,2,0),(1737,528,23628,0,0,'C80000',0,2,0),(1738,528,23625,0,1,'00C800',0,2,0),(1739,529,23357,0,0,'DD0000',0,2,0),(1740,529,23341,0,1,'00DDDD',0,2,0),(1741,529,23342,0,2,'3333FF',0,2,0),(1742,530,23345,0,0,'990099',0,2,0),(1743,530,23348,0,1,'990000',0,2,0),(1744,530,23355,0,2,'0000EE',0,2,0),(1745,530,23352,0,3,'FF33FF',0,2,0),(1746,530,23356,0,4,'00EE00',0,2,0),(1747,530,23354,0,5,'003300',0,2,0),(1748,530,23346,0,6,'33FFFF',0,2,0),(1749,530,23349,0,7,'DD0000',0,2,0),(1750,530,23344,0,8,'000099',0,7,0),(1751,531,23353,0,0,'FFAA00',0,2,0),(1752,531,23347,0,1,'990099',0,2,0),(1753,531,23350,0,2,'EE0000',0,2,0),(1754,531,23343,0,3,'FF66FF',0,2,0),(1755,532,23340,5,0,'00C800',0,2,0),(1756,532,23358,5,1,'C80000',1,2,0),(1757,531,23351,0,4,'960000',0,2,0),(1758,531,23360,0,5,'009600',0,2,0),(1759,410,23634,0,5,'00FF00',0,2,0),(1760,520,23276,0,0,'009900',0,2,0),(1761,520,23273,0,1,'DD0000',0,2,0),(1762,520,23275,0,2,'00DDDD',0,2,0),(1763,520,23274,0,3,'3333FF',0,2,0),(1764,520,23620,0,4,'999900',0,2,0),(1765,520,23635,0,5,'00FF00',0,2,0),(1766,533,22181,5,0,'00C800',0,2,0),(1792,534,23316,5,0,'00C800',0,2,0),(1806,540,22942,5,0,'00C800',0,2,0),(1808,541,22902,5,0,'00C800',0,2,0),(1810,542,22982,5,0,'00C800',0,2,0),(1812,543,23062,5,0,'00C800',0,2,0),(1814,544,22862,5,0,'00C800',0,2,0),(1816,545,23022,5,0,'00C800',0,2,0),(1818,546,23158,5,0,'00C800',0,2,0);
/*!40000 ALTER TABLE `graphs_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_discovery`
--

DROP TABLE IF EXISTS `group_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_discovery` (
  `groupid` bigint(20) unsigned NOT NULL,
  `parent_group_prototypeid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `c_group_discovery_2` (`parent_group_prototypeid`),
  CONSTRAINT `c_group_discovery_2` FOREIGN KEY (`parent_group_prototypeid`) REFERENCES `group_prototype` (`group_prototypeid`),
  CONSTRAINT `c_group_discovery_1` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_discovery`
--

LOCK TABLES `group_discovery` WRITE;
/*!40000 ALTER TABLE `group_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_prototype`
--

DROP TABLE IF EXISTS `group_prototype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_prototype` (
  `group_prototypeid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`group_prototypeid`),
  KEY `group_prototype_1` (`hostid`),
  KEY `c_group_prototype_2` (`groupid`),
  KEY `c_group_prototype_3` (`templateid`),
  CONSTRAINT `c_group_prototype_3` FOREIGN KEY (`templateid`) REFERENCES `group_prototype` (`group_prototypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_group_prototype_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_prototype`
--

LOCK TABLES `group_prototype` WRITE;
/*!40000 ALTER TABLE `group_prototype` DISABLE KEYS */;
INSERT INTO `group_prototype` VALUES (1,10090,'{#HV.NAME}',NULL,NULL),(2,10090,'',6,NULL),(4,10092,'',7,NULL),(6,10090,'{#CLUSTER.NAME} (vm)',NULL,NULL),(7,10092,'{#CLUSTER.NAME}',NULL,NULL);
/*!40000 ALTER TABLE `group_prototype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `groupid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `internal` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupid`),
  KEY `groups_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Templates',0,0),(2,'Linux servers',0,0),(4,'Zabbix servers',0,0),(5,'Discovered hosts',1,0),(6,'Virtual machines',0,0),(7,'Hypervisors',0,0);
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history`
--

DROP TABLE IF EXISTS `history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history`
--

LOCK TABLES `history` WRITE;
/*!40000 ALTER TABLE `history` DISABLE KEYS */;
/*!40000 ALTER TABLE `history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_log`
--

DROP TABLE IF EXISTS `history_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_log` (
  `id` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `history_log_2` (`itemid`,`id`),
  KEY `history_log_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_log`
--

LOCK TABLES `history_log` WRITE;
/*!40000 ALTER TABLE `history_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str`
--

DROP TABLE IF EXISTS `history_str`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_str_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str`
--

LOCK TABLES `history_str` WRITE;
/*!40000 ALTER TABLE `history_str` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_str_sync`
--

DROP TABLE IF EXISTS `history_str_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_str_sync` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `history_str_sync_1` (`nodeid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_str_sync`
--

LOCK TABLES `history_str_sync` WRITE;
/*!40000 ALTER TABLE `history_str_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_str_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_sync`
--

DROP TABLE IF EXISTS `history_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_sync` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` double(16,4) NOT NULL DEFAULT '0.0000',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `history_sync_1` (`nodeid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_sync`
--

LOCK TABLES `history_sync` WRITE;
/*!40000 ALTER TABLE `history_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_text`
--

DROP TABLE IF EXISTS `history_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_text` (
  `id` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `history_text_2` (`itemid`,`id`),
  KEY `history_text_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_text`
--

LOCK TABLES `history_text` WRITE;
/*!40000 ALTER TABLE `history_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint`
--

DROP TABLE IF EXISTS `history_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  KEY `history_uint_1` (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint`
--

LOCK TABLES `history_uint` WRITE;
/*!40000 ALTER TABLE `history_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_uint_sync`
--

DROP TABLE IF EXISTS `history_uint_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_uint_sync` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nodeid` int(11) NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` bigint(20) unsigned NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `history_uint_sync_1` (`nodeid`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_uint_sync`
--

LOCK TABLES `history_uint_sync` WRITE;
/*!40000 ALTER TABLE `history_uint_sync` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_uint_sync` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_discovery`
--

DROP TABLE IF EXISTS `host_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_discovery` (
  `hostid` bigint(20) unsigned NOT NULL,
  `parent_hostid` bigint(20) unsigned DEFAULT NULL,
  `parent_itemid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hostid`),
  KEY `c_host_discovery_2` (`parent_hostid`),
  KEY `c_host_discovery_3` (`parent_itemid`),
  CONSTRAINT `c_host_discovery_3` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`),
  CONSTRAINT `c_host_discovery_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_host_discovery_2` FOREIGN KEY (`parent_hostid`) REFERENCES `hosts` (`hostid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_discovery`
--

LOCK TABLES `host_discovery` WRITE;
/*!40000 ALTER TABLE `host_discovery` DISABLE KEYS */;
INSERT INTO `host_discovery` VALUES (10090,NULL,23542,'',0,0),(10092,NULL,23554,'',0,0);
/*!40000 ALTER TABLE `host_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `host_inventory`
--

DROP TABLE IF EXISTS `host_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `host_inventory` (
  `hostid` bigint(20) unsigned NOT NULL,
  `inventory_mode` int(11) NOT NULL DEFAULT '0',
  `type` varchar(64) NOT NULL DEFAULT '',
  `type_full` varchar(64) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `alias` varchar(64) NOT NULL DEFAULT '',
  `os` varchar(64) NOT NULL DEFAULT '',
  `os_full` varchar(255) NOT NULL DEFAULT '',
  `os_short` varchar(64) NOT NULL DEFAULT '',
  `serialno_a` varchar(64) NOT NULL DEFAULT '',
  `serialno_b` varchar(64) NOT NULL DEFAULT '',
  `tag` varchar(64) NOT NULL DEFAULT '',
  `asset_tag` varchar(64) NOT NULL DEFAULT '',
  `macaddress_a` varchar(64) NOT NULL DEFAULT '',
  `macaddress_b` varchar(64) NOT NULL DEFAULT '',
  `hardware` varchar(255) NOT NULL DEFAULT '',
  `hardware_full` text NOT NULL,
  `software` varchar(255) NOT NULL DEFAULT '',
  `software_full` text NOT NULL,
  `software_app_a` varchar(64) NOT NULL DEFAULT '',
  `software_app_b` varchar(64) NOT NULL DEFAULT '',
  `software_app_c` varchar(64) NOT NULL DEFAULT '',
  `software_app_d` varchar(64) NOT NULL DEFAULT '',
  `software_app_e` varchar(64) NOT NULL DEFAULT '',
  `contact` text NOT NULL,
  `location` text NOT NULL,
  `location_lat` varchar(16) NOT NULL DEFAULT '',
  `location_lon` varchar(16) NOT NULL DEFAULT '',
  `notes` text NOT NULL,
  `chassis` varchar(64) NOT NULL DEFAULT '',
  `model` varchar(64) NOT NULL DEFAULT '',
  `hw_arch` varchar(32) NOT NULL DEFAULT '',
  `vendor` varchar(64) NOT NULL DEFAULT '',
  `contract_number` varchar(64) NOT NULL DEFAULT '',
  `installer_name` varchar(64) NOT NULL DEFAULT '',
  `deployment_status` varchar(64) NOT NULL DEFAULT '',
  `url_a` varchar(255) NOT NULL DEFAULT '',
  `url_b` varchar(255) NOT NULL DEFAULT '',
  `url_c` varchar(255) NOT NULL DEFAULT '',
  `host_networks` text NOT NULL,
  `host_netmask` varchar(39) NOT NULL DEFAULT '',
  `host_router` varchar(39) NOT NULL DEFAULT '',
  `oob_ip` varchar(39) NOT NULL DEFAULT '',
  `oob_netmask` varchar(39) NOT NULL DEFAULT '',
  `oob_router` varchar(39) NOT NULL DEFAULT '',
  `date_hw_purchase` varchar(64) NOT NULL DEFAULT '',
  `date_hw_install` varchar(64) NOT NULL DEFAULT '',
  `date_hw_expiry` varchar(64) NOT NULL DEFAULT '',
  `date_hw_decomm` varchar(64) NOT NULL DEFAULT '',
  `site_address_a` varchar(128) NOT NULL DEFAULT '',
  `site_address_b` varchar(128) NOT NULL DEFAULT '',
  `site_address_c` varchar(128) NOT NULL DEFAULT '',
  `site_city` varchar(128) NOT NULL DEFAULT '',
  `site_state` varchar(64) NOT NULL DEFAULT '',
  `site_country` varchar(64) NOT NULL DEFAULT '',
  `site_zip` varchar(64) NOT NULL DEFAULT '',
  `site_rack` varchar(128) NOT NULL DEFAULT '',
  `site_notes` text NOT NULL,
  `poc_1_name` varchar(128) NOT NULL DEFAULT '',
  `poc_1_email` varchar(128) NOT NULL DEFAULT '',
  `poc_1_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_1_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_1_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_1_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_1_notes` text NOT NULL,
  `poc_2_name` varchar(128) NOT NULL DEFAULT '',
  `poc_2_email` varchar(128) NOT NULL DEFAULT '',
  `poc_2_phone_a` varchar(64) NOT NULL DEFAULT '',
  `poc_2_phone_b` varchar(64) NOT NULL DEFAULT '',
  `poc_2_cell` varchar(64) NOT NULL DEFAULT '',
  `poc_2_screen` varchar(64) NOT NULL DEFAULT '',
  `poc_2_notes` text NOT NULL,
  PRIMARY KEY (`hostid`),
  CONSTRAINT `c_host_inventory_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `host_inventory`
--

LOCK TABLES `host_inventory` WRITE;
/*!40000 ALTER TABLE `host_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `host_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hostmacro`
--

DROP TABLE IF EXISTS `hostmacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hostmacro` (
  `hostmacroid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `macro` varchar(64) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`hostmacroid`),
  UNIQUE KEY `hostmacro_1` (`hostid`,`macro`),
  CONSTRAINT `c_hostmacro_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hostmacro`
--

LOCK TABLES `hostmacro` WRITE;
/*!40000 ALTER TABLE `hostmacro` DISABLE KEYS */;
/*!40000 ALTER TABLE `hostmacro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts`
--

DROP TABLE IF EXISTS `hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts` (
  `hostid` bigint(20) unsigned NOT NULL,
  `proxy_hostid` bigint(20) unsigned DEFAULT NULL,
  `host` varchar(64) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `disable_until` int(11) NOT NULL DEFAULT '0',
  `error` varchar(128) NOT NULL DEFAULT '',
  `available` int(11) NOT NULL DEFAULT '0',
  `errors_from` int(11) NOT NULL DEFAULT '0',
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `ipmi_authtype` int(11) NOT NULL DEFAULT '0',
  `ipmi_privilege` int(11) NOT NULL DEFAULT '2',
  `ipmi_username` varchar(16) NOT NULL DEFAULT '',
  `ipmi_password` varchar(20) NOT NULL DEFAULT '',
  `ipmi_disable_until` int(11) NOT NULL DEFAULT '0',
  `ipmi_available` int(11) NOT NULL DEFAULT '0',
  `snmp_disable_until` int(11) NOT NULL DEFAULT '0',
  `snmp_available` int(11) NOT NULL DEFAULT '0',
  `maintenanceid` bigint(20) unsigned DEFAULT NULL,
  `maintenance_status` int(11) NOT NULL DEFAULT '0',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `maintenance_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_errors_from` int(11) NOT NULL DEFAULT '0',
  `snmp_errors_from` int(11) NOT NULL DEFAULT '0',
  `ipmi_error` varchar(128) NOT NULL DEFAULT '',
  `snmp_error` varchar(128) NOT NULL DEFAULT '',
  `jmx_disable_until` int(11) NOT NULL DEFAULT '0',
  `jmx_available` int(11) NOT NULL DEFAULT '0',
  `jmx_errors_from` int(11) NOT NULL DEFAULT '0',
  `jmx_error` varchar(128) NOT NULL DEFAULT '',
  `name` varchar(64) NOT NULL DEFAULT '',
  `flags` int(11) NOT NULL DEFAULT '0',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`hostid`),
  KEY `hosts_1` (`host`),
  KEY `hosts_2` (`status`),
  KEY `hosts_3` (`proxy_hostid`),
  KEY `hosts_4` (`name`),
  KEY `hosts_5` (`maintenanceid`),
  KEY `c_hosts_3` (`templateid`),
  CONSTRAINT `c_hosts_3` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_1` FOREIGN KEY (`proxy_hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_hosts_2` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts`
--

LOCK TABLES `hosts` WRITE;
/*!40000 ALTER TABLE `hosts` DISABLE KEYS */;
INSERT INTO `hosts` VALUES (10001,NULL,'Template OS Linux',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Linux',0,NULL),(10047,NULL,'Template App Zabbix Server',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Server',0,NULL),(10048,NULL,'Template App Zabbix Proxy',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Proxy',0,NULL),(10050,NULL,'Template App Zabbix Agent',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Zabbix Agent',0,NULL),(10060,NULL,'Template SNMP Interfaces',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Interfaces',0,NULL),(10065,NULL,'Template SNMP Generic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Generic',0,NULL),(10066,NULL,'Template SNMP Device',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Device',0,NULL),(10067,NULL,'Template SNMP OS Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP OS Windows',0,NULL),(10068,NULL,'Template SNMP Disks',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Disks',0,NULL),(10069,NULL,'Template SNMP OS Linux',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP OS Linux',0,NULL),(10070,NULL,'Template SNMP Processors',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template SNMP Processors',0,NULL),(10071,NULL,'Template IPMI Intel SR1530',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template IPMI Intel SR1530',0,NULL),(10072,NULL,'Template IPMI Intel SR1630',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template IPMI Intel SR1630',0,NULL),(10073,NULL,'Template App MySQL',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App MySQL',0,NULL),(10074,NULL,'Template OS OpenBSD',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS OpenBSD',0,NULL),(10075,NULL,'Template OS FreeBSD',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS FreeBSD',0,NULL),(10076,NULL,'Template OS AIX',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS AIX',0,NULL),(10077,NULL,'Template OS HP-UX',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS HP-UX',0,NULL),(10078,NULL,'Template OS Solaris',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Solaris',0,NULL),(10079,NULL,'Template OS Mac OS X',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Mac OS X',0,NULL),(10081,NULL,'Template OS Windows',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template OS Windows',0,NULL),(10082,NULL,'Template JMX Generic',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template JMX Generic',0,NULL),(10083,NULL,'Template JMX Tomcat',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template JMX Tomcat',0,NULL),(10084,NULL,'Zabbix server',1,0,'',0,0,0,-1,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Zabbix server',0,NULL),(10088,NULL,'Template Virt VMware',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Virt VMware',0,NULL),(10089,NULL,'Template Virt VMware Guest',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Virt VMware Guest',0,NULL),(10090,NULL,'{#VM.UUID}',0,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#VM.NAME}',2,NULL),(10091,NULL,'Template Virt VMware Hypervisor',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template Virt VMware Hypervisor',0,NULL),(10092,NULL,'{#HV.UUID}',0,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','{#HV.NAME}',2,NULL),(10093,NULL,'Template App FTP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App FTP Service',0,NULL),(10094,NULL,'Template App HTTP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App HTTP Service',0,NULL),(10095,NULL,'Template App HTTPS Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App HTTPS Service',0,NULL),(10096,NULL,'Template App IMAP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App IMAP Service',0,NULL),(10097,NULL,'Template App LDAP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App LDAP Service',0,NULL),(10098,NULL,'Template App NNTP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App NNTP Service',0,NULL),(10099,NULL,'Template App NTP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App NTP Service',0,NULL),(10100,NULL,'Template App POP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App POP Service',0,NULL),(10101,NULL,'Template App SMTP Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App SMTP Service',0,NULL),(10102,NULL,'Template App SSH Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App SSH Service',0,NULL),(10103,NULL,'Template App Telnet Service',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template App Telnet Service',0,NULL),(10104,NULL,'Template ICMP Ping',3,0,'',0,0,0,0,2,'','',0,0,0,0,NULL,0,0,0,0,0,'','',0,0,0,'','Template ICMP Ping',0,NULL);
/*!40000 ALTER TABLE `hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_groups`
--

DROP TABLE IF EXISTS `hosts_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_groups` (
  `hostgroupid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hostgroupid`),
  UNIQUE KEY `hosts_groups_1` (`hostid`,`groupid`),
  KEY `hosts_groups_2` (`groupid`),
  CONSTRAINT `c_hosts_groups_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_groups_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_groups`
--

LOCK TABLES `hosts_groups` WRITE;
/*!40000 ALTER TABLE `hosts_groups` DISABLE KEYS */;
INSERT INTO `hosts_groups` VALUES (1,10001,1),(47,10047,1),(98,10048,1),(50,10050,1),(70,10060,1),(73,10065,1),(74,10066,1),(75,10067,1),(76,10068,1),(77,10069,1),(78,10070,1),(79,10071,1),(80,10072,1),(81,10073,1),(82,10074,1),(83,10075,1),(84,10076,1),(85,10077,1),(86,10078,1),(87,10079,1),(89,10081,1),(90,10082,1),(91,10083,1),(92,10084,4),(95,10088,1),(96,10089,1),(97,10091,1),(99,10093,1),(100,10094,1),(101,10095,1),(102,10096,1),(103,10097,1),(104,10098,1),(105,10099,1),(106,10100,1),(107,10101,1),(108,10102,1),(109,10103,1),(110,10104,1);
/*!40000 ALTER TABLE `hosts_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hosts_templates`
--

DROP TABLE IF EXISTS `hosts_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hosts_templates` (
  `hosttemplateid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`hosttemplateid`),
  UNIQUE KEY `hosts_templates_1` (`hostid`,`templateid`),
  KEY `hosts_templates_2` (`templateid`),
  CONSTRAINT `c_hosts_templates_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_hosts_templates_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hosts_templates`
--

LOCK TABLES `hosts_templates` WRITE;
/*!40000 ALTER TABLE `hosts_templates` DISABLE KEYS */;
INSERT INTO `hosts_templates` VALUES (4,10001,10050),(22,10066,10060),(21,10066,10065),(24,10067,10060),(23,10067,10065),(25,10067,10068),(30,10067,10070),(28,10069,10060),(27,10069,10065),(26,10069,10068),(29,10069,10070),(31,10074,10050),(32,10075,10050),(33,10076,10050),(34,10077,10050),(35,10078,10050),(36,10079,10050),(37,10081,10050),(39,10084,10001),(38,10084,10047),(41,10090,10089),(42,10092,10091);
/*!40000 ALTER TABLE `hosts_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `housekeeper`
--

DROP TABLE IF EXISTS `housekeeper`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `housekeeper` (
  `housekeeperid` bigint(20) unsigned NOT NULL,
  `tablename` varchar(64) NOT NULL DEFAULT '',
  `field` varchar(64) NOT NULL DEFAULT '',
  `value` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`housekeeperid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `housekeeper`
--

LOCK TABLES `housekeeper` WRITE;
/*!40000 ALTER TABLE `housekeeper` DISABLE KEYS */;
/*!40000 ALTER TABLE `housekeeper` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstep`
--

DROP TABLE IF EXISTS `httpstep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstep` (
  `httpstepid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `no` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `timeout` int(11) NOT NULL DEFAULT '30',
  `posts` text NOT NULL,
  `required` varchar(255) NOT NULL DEFAULT '',
  `status_codes` varchar(255) NOT NULL DEFAULT '',
  `variables` text NOT NULL,
  PRIMARY KEY (`httpstepid`),
  KEY `httpstep_1` (`httptestid`),
  CONSTRAINT `c_httpstep_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstep`
--

LOCK TABLES `httpstep` WRITE;
/*!40000 ALTER TABLE `httpstep` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httpstepitem`
--

DROP TABLE IF EXISTS `httpstepitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httpstepitem` (
  `httpstepitemid` bigint(20) unsigned NOT NULL,
  `httpstepid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httpstepitemid`),
  UNIQUE KEY `httpstepitem_1` (`httpstepid`,`itemid`),
  KEY `httpstepitem_2` (`itemid`),
  CONSTRAINT `c_httpstepitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_httpstepitem_1` FOREIGN KEY (`httpstepid`) REFERENCES `httpstep` (`httpstepid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httpstepitem`
--

LOCK TABLES `httpstepitem` WRITE;
/*!40000 ALTER TABLE `httpstepitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httpstepitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptest`
--

DROP TABLE IF EXISTS `httptest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptest` (
  `httptestid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `applicationid` bigint(20) unsigned DEFAULT NULL,
  `nextcheck` int(11) NOT NULL DEFAULT '0',
  `delay` int(11) NOT NULL DEFAULT '60',
  `status` int(11) NOT NULL DEFAULT '0',
  `variables` text NOT NULL,
  `agent` varchar(255) NOT NULL DEFAULT '',
  `authentication` int(11) NOT NULL DEFAULT '0',
  `http_user` varchar(64) NOT NULL DEFAULT '',
  `http_password` varchar(64) NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `http_proxy` varchar(255) NOT NULL DEFAULT '',
  `retries` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`httptestid`),
  UNIQUE KEY `httptest_2` (`hostid`,`name`),
  KEY `httptest_1` (`applicationid`),
  KEY `httptest_3` (`status`),
  KEY `httptest_4` (`templateid`),
  CONSTRAINT `c_httptest_3` FOREIGN KEY (`templateid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptest_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`),
  CONSTRAINT `c_httptest_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptest`
--

LOCK TABLES `httptest` WRITE;
/*!40000 ALTER TABLE `httptest` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `httptestitem`
--

DROP TABLE IF EXISTS `httptestitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `httptestitem` (
  `httptestitemid` bigint(20) unsigned NOT NULL,
  `httptestid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`httptestitemid`),
  UNIQUE KEY `httptestitem_1` (`httptestid`,`itemid`),
  KEY `httptestitem_2` (`itemid`),
  CONSTRAINT `c_httptestitem_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_httptestitem_1` FOREIGN KEY (`httptestid`) REFERENCES `httptest` (`httptestid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `httptestitem`
--

LOCK TABLES `httptestitem` WRITE;
/*!40000 ALTER TABLE `httptestitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `httptestitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_map`
--

DROP TABLE IF EXISTS `icon_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_map` (
  `iconmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `default_iconid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`iconmapid`),
  KEY `icon_map_1` (`name`),
  KEY `icon_map_2` (`default_iconid`),
  CONSTRAINT `c_icon_map_1` FOREIGN KEY (`default_iconid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_map`
--

LOCK TABLES `icon_map` WRITE;
/*!40000 ALTER TABLE `icon_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `icon_mapping`
--

DROP TABLE IF EXISTS `icon_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `icon_mapping` (
  `iconmappingid` bigint(20) unsigned NOT NULL,
  `iconmapid` bigint(20) unsigned NOT NULL,
  `iconid` bigint(20) unsigned NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `expression` varchar(64) NOT NULL DEFAULT '',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iconmappingid`),
  KEY `icon_mapping_1` (`iconmapid`),
  KEY `icon_mapping_2` (`iconid`),
  CONSTRAINT `c_icon_mapping_2` FOREIGN KEY (`iconid`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_icon_mapping_1` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `icon_mapping`
--

LOCK TABLES `icon_mapping` WRITE;
/*!40000 ALTER TABLE `icon_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `icon_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ids`
--

DROP TABLE IF EXISTS `ids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ids` (
  `nodeid` int(11) NOT NULL,
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `field_name` varchar(64) NOT NULL DEFAULT '',
  `nextid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`nodeid`,`table_name`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ids`
--

LOCK TABLES `ids` WRITE;
/*!40000 ALTER TABLE `ids` DISABLE KEYS */;
INSERT INTO `ids` VALUES (0,'actions','actionid',7),(0,'auditlog','auditid',2),(0,'operations','operationid',8),(0,'optemplate','optemplateid',2),(0,'profiles','profileid',13),(0,'user_history','userhistoryid',1);
/*!40000 ALTER TABLE `ids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `imageid` bigint(20) unsigned NOT NULL,
  `imagetype` int(11) NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '0',
  `image` longblob NOT NULL,
  PRIMARY KEY (`imageid`),
  KEY `images_1` (`imagetype`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface`
--

DROP TABLE IF EXISTS `interface`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  `main` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL DEFAULT '0',
  `useip` int(11) NOT NULL DEFAULT '1',
  `ip` varchar(64) NOT NULL DEFAULT '127.0.0.1',
  `dns` varchar(64) NOT NULL DEFAULT '',
  `port` varchar(64) NOT NULL DEFAULT '10050',
  PRIMARY KEY (`interfaceid`),
  KEY `interface_1` (`hostid`,`type`),
  KEY `interface_2` (`ip`,`dns`),
  CONSTRAINT `c_interface_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface`
--

LOCK TABLES `interface` WRITE;
/*!40000 ALTER TABLE `interface` DISABLE KEYS */;
INSERT INTO `interface` VALUES (1,10084,1,1,1,'127.0.0.1','','10050');
/*!40000 ALTER TABLE `interface` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interface_discovery`
--

DROP TABLE IF EXISTS `interface_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interface_discovery` (
  `interfaceid` bigint(20) unsigned NOT NULL,
  `parent_interfaceid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`interfaceid`),
  KEY `c_interface_discovery_2` (`parent_interfaceid`),
  CONSTRAINT `c_interface_discovery_2` FOREIGN KEY (`parent_interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE,
  CONSTRAINT `c_interface_discovery_1` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interface_discovery`
--

LOCK TABLES `interface_discovery` WRITE;
/*!40000 ALTER TABLE `interface_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `interface_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_discovery`
--

DROP TABLE IF EXISTS `item_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_discovery` (
  `itemdiscoveryid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  `parent_itemid` bigint(20) unsigned NOT NULL,
  `key_` varchar(255) NOT NULL DEFAULT '',
  `lastcheck` int(11) NOT NULL DEFAULT '0',
  `ts_delete` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemdiscoveryid`),
  UNIQUE KEY `item_discovery_1` (`itemid`,`parent_itemid`),
  KEY `item_discovery_2` (`parent_itemid`),
  CONSTRAINT `c_item_discovery_2` FOREIGN KEY (`parent_itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_item_discovery_1` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_discovery`
--

LOCK TABLES `item_discovery` WRITE;
/*!40000 ALTER TABLE `item_discovery` DISABLE KEYS */;
INSERT INTO `item_discovery` VALUES (1,22446,22444,'',0,0),(3,22448,22444,'',0,0),(5,22452,22450,'',0,0),(7,22454,22450,'',0,0),(9,22456,22450,'',0,0),(11,22458,22450,'',0,0),(65,22686,22450,'',0,0),(68,22701,22700,'',0,0),(69,22702,22700,'',0,0),(70,22703,22700,'',0,0),(71,22704,22700,'',0,0),(72,22705,22700,'',0,0),(73,22706,22700,'',0,0),(74,22707,22700,'',0,0),(75,22708,22700,'',0,0),(76,22721,22720,'',0,0),(77,22722,22720,'',0,0),(78,22723,22720,'',0,0),(79,22724,22720,'',0,0),(80,22725,22720,'',0,0),(81,22726,22720,'',0,0),(82,22727,22720,'',0,0),(83,22728,22720,'',0,0),(84,22736,22735,'',0,0),(85,22737,22735,'',0,0),(86,22738,22735,'',0,0),(87,22739,22735,'',0,0),(88,22740,22735,'',0,0),(89,22741,22735,'',0,0),(90,22742,22735,'',0,0),(91,22743,22735,'',0,0),(94,22749,22746,'',0,0),(100,22755,22746,'',0,0),(101,22756,22746,'',0,0),(102,22757,22746,'',0,0),(103,22758,22746,'',0,0),(104,22759,22746,'',0,0),(105,22761,22760,'',0,0),(106,22762,22760,'',0,0),(107,22763,22760,'',0,0),(108,22764,22760,'',0,0),(109,22765,22760,'',0,0),(110,22766,22760,'',0,0),(111,22768,22767,'',0,0),(112,22769,22767,'',0,0),(113,22770,22767,'',0,0),(114,22771,22767,'',0,0),(115,22772,22767,'',0,0),(116,22773,22767,'',0,0),(117,22780,22779,'',0,0),(118,22781,22779,'',0,0),(119,22782,22779,'',0,0),(120,22783,22779,'',0,0),(121,22784,22779,'',0,0),(122,22785,22779,'',0,0),(123,22786,22779,'',0,0),(124,22787,22779,'',0,0),(128,22793,22789,'',0,0),(131,22797,22796,'',0,0),(132,22799,22798,'',0,0),(135,22868,22867,'',0,0),(136,22869,22867,'',0,0),(137,22870,22867,'',0,0),(138,22871,22867,'',0,0),(139,22872,22867,'',0,0),(142,22908,22907,'',0,0),(143,22909,22907,'',0,0),(144,22910,22907,'',0,0),(145,22911,22907,'',0,0),(146,22912,22907,'',0,0),(147,22945,22944,'',0,0),(148,22946,22944,'',0,0),(149,22948,22947,'',0,0),(150,22949,22947,'',0,0),(151,22950,22947,'',0,0),(152,22951,22947,'',0,0),(153,22952,22947,'',0,0),(154,22985,22984,'',0,0),(155,22986,22984,'',0,0),(156,22988,22987,'',0,0),(157,22989,22987,'',0,0),(158,22990,22987,'',0,0),(159,22991,22987,'',0,0),(160,22992,22987,'',0,0),(161,23025,23024,'',0,0),(162,23026,23024,'',0,0),(163,23028,23027,'',0,0),(164,23029,23027,'',0,0),(165,23030,23027,'',0,0),(166,23031,23027,'',0,0),(167,23032,23027,'',0,0),(170,23068,23067,'',0,0),(171,23069,23067,'',0,0),(172,23070,23067,'',0,0),(173,23071,23067,'',0,0),(174,23072,23067,'',0,0),(175,23164,23162,'',0,0),(176,23165,23162,'',0,0),(178,23167,23162,'',0,0),(179,23168,23162,'',0,0),(180,23169,23163,'',0,0),(181,23170,23163,'',0,0),(182,23280,23278,'',0,0),(183,23281,23278,'',0,0),(184,23282,23279,'',0,0),(185,23283,23279,'',0,0),(186,23284,23279,'',0,0),(187,23285,23279,'',0,0),(188,23286,23279,'',0,0),(189,23073,23540,'',0,0),(190,23074,23540,'',0,0),(191,23075,23329,'',0,0),(192,23076,23329,'',0,0),(193,23576,23575,'',0,0),(194,23577,23575,'',0,0),(195,23578,23575,'',0,0),(196,23579,23575,'',0,0),(201,23596,23595,'',0,0),(202,23601,23599,'',0,0),(203,23602,23599,'',0,0),(204,23603,23599,'',0,0),(205,23604,23599,'',0,0),(206,23605,23600,'',0,0),(207,23606,23600,'',0,0),(208,23607,23600,'',0,0),(209,23608,23600,'',0,0),(218,23632,23631,'',0,0),(219,23633,23631,'',0,0);
/*!40000 ALTER TABLE `item_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `itemid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `snmp_community` varchar(64) NOT NULL DEFAULT '',
  `snmp_oid` varchar(255) NOT NULL DEFAULT '',
  `hostid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '0',
  `history` int(11) NOT NULL DEFAULT '90',
  `trends` int(11) NOT NULL DEFAULT '365',
  `status` int(11) NOT NULL DEFAULT '0',
  `value_type` int(11) NOT NULL DEFAULT '0',
  `trapper_hosts` varchar(255) NOT NULL DEFAULT '',
  `units` varchar(255) NOT NULL DEFAULT '',
  `multiplier` int(11) NOT NULL DEFAULT '0',
  `delta` int(11) NOT NULL DEFAULT '0',
  `snmpv3_securityname` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_securitylevel` int(11) NOT NULL DEFAULT '0',
  `snmpv3_authpassphrase` varchar(64) NOT NULL DEFAULT '',
  `snmpv3_privpassphrase` varchar(64) NOT NULL DEFAULT '',
  `formula` varchar(255) NOT NULL DEFAULT '1',
  `error` varchar(128) NOT NULL DEFAULT '',
  `lastlogsize` bigint(20) unsigned NOT NULL DEFAULT '0',
  `logtimefmt` varchar(64) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `valuemapid` bigint(20) unsigned DEFAULT NULL,
  `delay_flex` varchar(255) NOT NULL DEFAULT '',
  `params` text NOT NULL,
  `ipmi_sensor` varchar(128) NOT NULL DEFAULT '',
  `data_type` int(11) NOT NULL DEFAULT '0',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `mtime` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `filter` varchar(255) NOT NULL DEFAULT '',
  `interfaceid` bigint(20) unsigned DEFAULT NULL,
  `port` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `inventory_link` int(11) NOT NULL DEFAULT '0',
  `lifetime` varchar(64) NOT NULL DEFAULT '30',
  `snmpv3_authprotocol` int(11) NOT NULL DEFAULT '0',
  `snmpv3_privprotocol` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `snmpv3_contextname` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`itemid`),
  UNIQUE KEY `items_1` (`hostid`,`key_`),
  KEY `items_3` (`status`),
  KEY `items_4` (`templateid`),
  KEY `items_5` (`valuemapid`),
  KEY `items_6` (`interfaceid`),
  CONSTRAINT `c_items_4` FOREIGN KEY (`interfaceid`) REFERENCES `interface` (`interfaceid`),
  CONSTRAINT `c_items_1` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_2` FOREIGN KEY (`templateid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_3` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (10009,0,'','',10001,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Total number of processes in any state.',0,'0',0,0,0,''),(10010,0,'','',10001,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,''),(10013,0,'','',10001,'Number of running processes','proc.num[,,run]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of processes in running state.',0,'0',0,0,0,''),(10014,0,'','',10001,'Free swap space','system.swap.size[,free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(10016,0,'','',10001,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of users who are currently logged in.',0,'0',0,0,0,''),(10019,0,'','',10001,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(10020,0,'','',10001,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(10025,0,'','',10001,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(10026,0,'','',10001,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(10030,0,'','',10001,'Total swap space','system.swap.size[,total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(10055,0,'','',10001,'Maximum number of processes','kernel.maxproc',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0',0,0,0,''),(10056,0,'','',10001,'Maximum number of opened files','kernel.maxfiles',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0',0,0,0,''),(10057,0,'','',10001,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','System host name.',3,'0',0,0,0,''),(10058,0,'','',10001,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'0',0,0,0,''),(10059,0,'','',10001,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(17318,0,'','',10001,'Host boot time','system.boottime',600,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(17350,0,'','',10001,'Free swap space in %','system.swap.size[,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(17352,0,'','',10001,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(17354,0,'','',10001,'CPU $2 time','system.cpu.util[,idle]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'0',0,0,0,''),(17356,0,'','',10001,'CPU $2 time','system.cpu.util[,user]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'0',0,0,0,''),(17358,0,'','',10001,'CPU $2 time','system.cpu.util[,nice]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that have been niced.',0,'0',0,0,0,''),(17360,0,'','',10001,'CPU $2 time','system.cpu.util[,system]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'0',0,0,0,''),(17362,0,'','',10001,'CPU $2 time','system.cpu.util[,iowait]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Amount of time the CPU has been waiting for I/O to complete.',0,'0',0,0,0,''),(22181,0,'','',10001,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'0',0,0,0,''),(22183,5,'','',10047,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22185,5,'','',10047,'Zabbix $2 write cache, % free','zabbix[wcache,trend,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22187,5,'','',10047,'Values processed by Zabbix server per second','zabbix[wcache,values]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22189,5,'','',10047,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22191,5,'','',10047,'Zabbix value cache, % free','zabbix[vcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22196,5,'','',10047,'Zabbix value cache hits','zabbix[vcache,cache,hits]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22199,5,'','',10047,'Zabbix value cache misses','zabbix[vcache,cache,misses]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22219,5,'','',10047,'Zabbix queue over $2','zabbix[queue,10m]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22231,0,'','',10050,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22232,0,'','',10050,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(22396,5,'','',10047,'Zabbix $2 write cache, % free','zabbix[wcache,text,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22399,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22400,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22401,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,vmware collector,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22402,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22404,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22406,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22408,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22410,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,db watchdog,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22412,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22414,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22416,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22418,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22420,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,proxy poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22422,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,escalator,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22424,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,alerter,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22426,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,timer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22428,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,node watcher,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22430,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22444,0,'','',10001,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(22446,0,'','',10001,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22448,0,'','',10001,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22450,0,'','',10001,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(22452,0,'','',10001,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22454,0,'','',10001,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22456,0,'','',10001,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22458,0,'','',10001,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22665,0,'','',10001,'CPU $2 time','system.cpu.util[,steal]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The amount of CPU \'stolen\' from this virtual machine by the hypervisor for other tasks (such as running another virtual machine).',0,'0',0,0,0,''),(22668,0,'','',10001,'CPU $2 time','system.cpu.util[,softirq]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The amount of time the CPU has been servicing software interrupts.',0,'0',0,0,0,''),(22671,0,'','',10001,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The amount of time the CPU has been servicing hardware interrupts.',0,'0',0,0,0,''),(22674,0,'','',10001,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,''),(22677,0,'','',10001,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,''),(22680,0,'','',10001,'Context switches per second','system.cpu.switches',60,7,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22683,0,'','',10001,'Interrupts per second','system.cpu.intr',60,7,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22686,0,'','',10001,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22689,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22700,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10060,'Network interfaces','ifDescr',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22701,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10060,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22702,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10060,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22703,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10060,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0',0,0,0,''),(22704,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10060,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,8,'','','',0,0,'','','','',0,2,'',NULL,'','The current operational state of the interface.',0,'0',0,0,0,''),(22705,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10060,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,11,'','','',0,0,'','','','',0,2,'',NULL,'','The desired state of the interface.',0,'0',0,0,0,''),(22706,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10060,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0',0,0,0,''),(22707,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10060,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0',0,0,0,''),(22708,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10060,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22709,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10060,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0',0,0,0,''),(22710,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10065,'Device description','sysDescr',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0',0,0,0,''),(22711,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10065,'Device name','sysName',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0',0,0,0,''),(22712,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10065,'Device location','sysLocation',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0',0,0,0,''),(22713,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10065,'Device contact details','sysContact',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0',0,0,0,''),(22714,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10065,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0',0,0,0,''),(22715,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10066,'Device contact details','sysContact',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22713,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0',0,0,0,''),(22716,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10066,'Device description','sysDescr',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22710,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0',0,0,0,''),(22717,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10066,'Device location','sysLocation',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22712,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0',0,0,0,''),(22718,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10066,'Device name','sysName',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22711,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0',0,0,0,''),(22719,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10066,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',22714,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0',0,0,0,''),(22720,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10066,'Network interfaces','ifDescr',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22700,NULL,'','','',0,0,'','','','',0,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22721,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10066,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22705,11,'','','',0,0,'','','','',0,2,'',NULL,'','The desired state of the interface.',0,'0',0,0,0,''),(22722,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10066,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22708,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22723,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10066,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22703,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0',0,0,0,''),(22724,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10066,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',22706,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0',0,0,0,''),(22725,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10066,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22701,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22726,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10066,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22704,8,'','','',0,0,'','','','',0,2,'',NULL,'','The current operational state of the interface.',0,'0',0,0,0,''),(22727,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10066,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',22707,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0',0,0,0,''),(22728,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10066,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22702,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22729,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10066,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22709,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0',0,0,0,''),(22730,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10067,'Device contact details','sysContact',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22713,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0',0,0,0,''),(22731,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10067,'Device description','sysDescr',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22710,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0',0,0,0,''),(22732,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10067,'Device location','sysLocation',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22712,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0',0,0,0,''),(22733,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10067,'Device name','sysName',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22711,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0',0,0,0,''),(22734,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10067,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',22714,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0',0,0,0,''),(22735,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10067,'Network interfaces','ifDescr',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22700,NULL,'','','',0,0,'','','','',0,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22736,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10067,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22705,11,'','','',0,0,'','','','',0,2,'',NULL,'','The desired state of the interface.',0,'0',0,0,0,''),(22737,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10067,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22708,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22738,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10067,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22703,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0',0,0,0,''),(22739,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10067,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',22706,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0',0,0,0,''),(22740,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10067,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22701,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22741,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10067,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22704,8,'','','',0,0,'','','','',0,2,'',NULL,'','The current operational state of the interface.',0,'0',0,0,0,''),(22742,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10067,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',22707,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0',0,0,0,''),(22743,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10067,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22702,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22744,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10067,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22709,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0',0,0,0,''),(22746,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr',10068,'Disk partitions','hrStorageDescr',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#SNMPVALUE}:@Storage devices for SNMP discovery',NULL,'','The rule will discover all disk partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22749,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10068,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','A description of the type and instance of the storage described by this entry.',0,'0',0,0,0,''),(22755,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10068,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'0',0,0,0,''),(22756,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10068,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'0',0,0,0,''),(22757,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10068,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'0',0,0,0,''),(22758,15,'','',10068,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,'',NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'0',0,0,0,''),(22759,15,'','',10068,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,'',NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'0',0,0,0,''),(22760,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr',10067,'Disk partitions','hrStorageDescr',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22746,NULL,'','','',0,0,'','','','',0,1,'{#SNMPVALUE}:@Storage devices for SNMP discovery',NULL,'','The rule will discover all disk partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22761,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10067,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22755,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'0',0,0,0,''),(22762,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10067,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22749,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','A description of the type and instance of the storage described by this entry.',0,'0',0,0,0,''),(22763,15,'','',10067,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22758,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,'',NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'0',0,0,0,''),(22764,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10067,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',22756,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'0',0,0,0,''),(22765,15,'','',10067,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22759,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,'',NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'0',0,0,0,''),(22766,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10067,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',22757,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'0',0,0,0,''),(22767,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr',10069,'Disk partitions','hrStorageDescr',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22746,NULL,'','','',0,0,'','','','',0,1,'{#SNMPVALUE}:@Storage devices for SNMP discovery',NULL,'','The rule will discover all disk partitions matching the global regexp \"Storage devices for SNMP discovery\".\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22768,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageAllocationUnits.{#SNMPINDEX}',10069,'Allocation units for storage $1','hrStorageAllocationUnits[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22755,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The size, in bytes, of the data objects allocated from this pool.  If this entry is monitoring sectors, blocks, buffers, or packets, for example, this number will commonly be greater than one.  Otherwise this number will typically be one.',0,'0',0,0,0,''),(22769,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageDescr.{#SNMPINDEX}',10069,'Description of storage $1','hrStorageDescr[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22749,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','A description of the type and instance of the storage described by this entry.',0,'0',0,0,0,''),(22770,15,'','',10069,'Total disk space on $1','hrStorageSizeInBytes[{#SNMPVALUE}]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22758,NULL,'','last(\"hrStorageSize[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,'',NULL,'','This is a calculated item, we need it to get total disk space in bytes.',0,'0',0,0,0,''),(22771,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageSize.{#SNMPINDEX}',10069,'Total disk space on $1 in units','hrStorageSize[{#SNMPVALUE}]',3600,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',22756,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The size of the storage represented by this entry, in units of hrStorageAllocationUnits. This object is writable to allow remote configuration of the size of the storage area in those cases where such an operation makes sense and is possible on the underlying system. For example, the amount of main memory allocated to a buffer pool might be modified or the amount of disk space allocated to virtual memory might be modified.',0,'0',0,0,0,''),(22772,15,'','',10069,'Used disk space on $1','hrStorageUsedInBytes[{#SNMPVALUE}]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22759,NULL,'','last(\"hrStorageUsed[{#SNMPVALUE}]\") * last(\"hrStorageAllocationUnits[{#SNMPVALUE}]\")','',0,0,'','','','',0,2,'',NULL,'','This is a calculated item, we need it to get used disk space in bytes.',0,'0',0,0,0,''),(22773,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrStorageUsed.{#SNMPINDEX}',10069,'Used disk space on $1 in units','hrStorageUsed[{#SNMPVALUE}]',60,7,365,0,3,'','units',0,0,'',0,'','','1','',0,'',22757,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The amount of the storage represented by this entry that is allocated, in units of hrStorageAllocationUnits.',0,'0',0,0,0,''),(22774,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysContact.0',10069,'Device contact details','sysContact',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22713,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The textual identification of the contact person for this managed node, together with information on how to contact this person.  If no contact information is known, the value is the zero-length string.',23,'0',0,0,0,''),(22775,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysDescr.0',10069,'Device description','sysDescr',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22710,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','A textual description of the entity.  This value should include the full name and version identification of the system\'s hardware type, software operating-system, and networking software.',14,'0',0,0,0,''),(22776,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysLocation.0',10069,'Device location','sysLocation',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22712,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The physical location of this node (e.g., `telephone closet, 3rd floor\').  If the location is unknown, the value is the zero-length string.',24,'0',0,0,0,''),(22777,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysName.0',10069,'Device name','sysName',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22711,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','An administratively-assigned name for this managed node. By convention, this is the node\'s fully-qualified domain name.  If the name is unknown, the value is the zero-length string.',3,'0',0,0,0,''),(22778,4,'{$SNMP_COMMUNITY}','SNMPv2-MIB::sysUpTime.0',10069,'Device uptime','sysUpTime',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.01','',0,'',22714,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time since the network management portion of the system was last re-initialized.',0,'0',0,0,0,''),(22779,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr',10069,'Network interfaces','ifDescr',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22700,NULL,'','','',0,0,'','','','',0,1,':',NULL,'','You may also consider using IF-MIB::ifType or IF-MIB::ifAlias for discovery depending on your filtering needs.\r\n\r\n{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22780,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAdminStatus.{#SNMPINDEX}',10069,'Admin status of interface $1','ifAdminStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22705,11,'','','',0,0,'','','','',0,2,'',NULL,'','The desired state of the interface.',0,'0',0,0,0,''),(22781,4,'{$SNMP_COMMUNITY}','IF-MIB::ifAlias.{#SNMPINDEX}',10069,'Alias of interface $1','ifAlias[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22708,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22782,4,'{$SNMP_COMMUNITY}','IF-MIB::ifDescr.{#SNMPINDEX}',10069,'Description of interface $1','ifDescr[{#SNMPVALUE}]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22703,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','A textual string containing information about the interface.  This string should include the name of the manufacturer, the product name and the version of the interface hardware/software.',0,'0',0,0,0,''),(22783,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInErrors.{#SNMPINDEX}',10069,'Inbound errors on interface $1','ifInErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',22706,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of inbound packets that contained errors preventing them from being deliverable to a higher-layer protocol.  For character-oriented or fixed-length interfaces, the number of inbound transmission units that contained errors preventing them from being deliverable to a higher-layer protocol.',0,'0',0,0,0,''),(22784,4,'{$SNMP_COMMUNITY}','IF-MIB::ifInOctets.{#SNMPINDEX}',10069,'Incoming traffic on interface $1','ifInOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22701,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets in valid MAC frames received on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22785,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOperStatus.{#SNMPINDEX}',10069,'Operational status of interface $1','ifOperStatus[{#SNMPVALUE}]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22704,8,'','','',0,0,'','','','',0,2,'',NULL,'','The current operational state of the interface.',0,'0',0,0,0,''),(22786,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutErrors.{#SNMPINDEX}',10069,'Outbound errors on interface $1','ifOutErrors[{#SNMPVALUE}]',60,7,365,0,3,'','',0,1,'',0,'','','1','',0,'',22707,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','For packet-oriented interfaces, the number of outbound packets that could not be transmitted because of errors. For character-oriented or fixed-length interfaces, the number of outbound transmission units that could not be transmitted because of errors.',0,'0',0,0,0,''),(22787,4,'{$SNMP_COMMUNITY}','IF-MIB::ifOutOctets.{#SNMPINDEX}',10069,'Outgoing traffic on interface $1','ifOutOctets[{#SNMPVALUE}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22702,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The number of octets transmitted in MAC frames on this interface, including the MAC header and FCS.',0,'0',0,0,0,''),(22788,4,'{$SNMP_COMMUNITY}','IF-MIB::ifNumber.0',10069,'Number of network interfaces','ifNumber',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22709,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The number of network interfaces (regardless of their current state) present on this system.',0,'0',0,0,0,''),(22789,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad',10070,'Processors','hrProcessorLoad',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,':',NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22793,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10070,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,0,3,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'0',0,0,0,''),(22796,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad',10069,'Processors','hrProcessorLoad',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22789,NULL,'','','',0,0,'','','','',0,1,':',NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22797,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10069,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,0,3,'','%',0,0,'',0,'','','1','',0,'',22793,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'0',0,0,0,''),(22798,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad',10067,'Processors','hrProcessorLoad',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22789,NULL,'','','',0,0,'','','','',0,1,':',NULL,'','{$SNMP_COMMUNITY} is a global macro.',0,'30',0,0,0,''),(22799,4,'{$SNMP_COMMUNITY}','HOST-RESOURCES-MIB::hrProcessorLoad.{#SNMPINDEX}',10067,'Utilization of processor #$1','hrProcessorLoad[{#SNMPINDEX}]',60,7,365,0,3,'','%',0,0,'',0,'','','1','',0,'',22793,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','The average, over the last minute, of the percentage of time that this processor was not idle. Implementations may approximate this one minute smoothing period if necessary.',0,'0',0,0,0,''),(22800,12,'','',10071,'BB +1.8V SM','bb_1.8v_sm',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.8V SM',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22801,12,'','',10071,'BB +3.3V','bb_3.3v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22802,12,'','',10071,'BB +3.3V STBY','bb_3.3v_stby',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V STBY',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22803,12,'','',10071,'BB +5.0V','bb_5.0v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +5.0V',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22804,12,'','',10071,'BB Ambient Temp','bb_ambient_temp',60,7,365,0,0,'','C',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB Ambient Temp',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22805,12,'','',10071,'Power','power',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','power',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22806,12,'','',10071,'Processor Vcc','processor_vcc',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','Processor Vcc',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22807,12,'','',10071,'System Fan 3','system_fan_3',60,7,365,0,0,'','RPM',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 3',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22808,12,'','',10072,'Baseboard Temp','baseboard_temp',60,7,365,0,0,'','C',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','Baseboard Temp',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22809,12,'','',10072,'BB +1.05V PCH','bb_1.05v_pch',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.05V PCH',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22810,12,'','',10072,'BB +1.1V P1 Vccp','bb_1.1v_p1_vccp',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.1V P1 Vccp',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22811,12,'','',10072,'BB +1.5V P1 DDR3','bb_1.5v_p1_ddr3',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +1.5V P1 DDR3',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22812,12,'','',10072,'BB +3.3V','bb_3.3v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22813,12,'','',10072,'BB +3.3V STBY','bb_3.3v_stby',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +3.3V STBY',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22814,12,'','',10072,'BB +5.0V','bb_5.0v',60,7,365,0,0,'','V',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','BB +5.0V',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22815,12,'','',10072,'Front Panel Temp','front_panel_temp',60,7,365,0,0,'','C',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','Front Panel Temp',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22816,12,'','',10072,'Power','power',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','power',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22817,12,'','',10072,'System Fan 2','system_fan_2',60,7,365,0,0,'','RPM',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 2',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22818,12,'','',10072,'System Fan 3','system_fan_3',60,7,365,0,0,'','RPM',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','System Fan 3',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22819,0,'','',10073,'MySQL status','mysql.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.ping, which is defined in userparameter_mysql.conf.\r\n\r\n0 - MySQL server is down\r\n1 - MySQL server is up',0,'30',0,0,0,''),(22820,0,'','',10073,'MySQL uptime','mysql.status[Uptime]',60,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22821,0,'','',10073,'MySQL version','mysql.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.version, which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22822,0,'','',10073,'MySQL insert operations per second','mysql.status[Com_insert]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22823,0,'','',10073,'MySQL select operations per second','mysql.status[Com_select]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22824,0,'','',10073,'MySQL update operations per second','mysql.status[Com_update]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22825,0,'','',10073,'MySQL rollback operations per second','mysql.status[Com_rollback]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22826,0,'','',10073,'MySQL commit operations per second','mysql.status[Com_commit]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22827,0,'','',10073,'MySQL begin operations per second','mysql.status[Com_begin]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22828,0,'','',10073,'MySQL delete operations per second','mysql.status[Com_delete]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22829,0,'','',10073,'MySQL bytes sent per second','mysql.status[Bytes_sent]',60,7,365,0,0,'','Bps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The number of bytes sent to all clients.\r\n\r\nIt requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22830,0,'','',10073,'MySQL bytes received per second','mysql.status[Bytes_received]',60,7,365,0,0,'','Bps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The number of bytes received from all clients. \r\n\r\nIt requires user parameter mysql.status[*], which is defined in \r\nuserparameter_mysql.conf.',0,'30',0,0,0,''),(22831,0,'','',10073,'MySQL queries per second','mysql.status[Questions]',60,7,365,0,0,'','qps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22832,0,'','',10073,'MySQL slow queries','mysql.status[Slow_queries]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It requires user parameter mysql.status[*], which is defined in userparameter_mysql.conf.',0,'30',0,0,0,''),(22833,0,'','',10074,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(22834,0,'','',10074,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22835,0,'','',10074,'Maximum number of opened files','kernel.maxfiles',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30',0,0,0,''),(22836,0,'','',10074,'Maximum number of processes','kernel.maxproc',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30',0,0,0,''),(22837,0,'','',10074,'Number of running processes','proc.num[,,run]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of processes in running state.',0,'30',0,0,0,''),(22838,0,'','',10074,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Total number of processes in any state.',0,'30',0,0,0,''),(22839,0,'','',10074,'Host boot time','system.boottime',600,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22840,0,'','',10074,'Interrupts per second','system.cpu.intr',60,7,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22841,0,'','',10074,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22842,0,'','',10074,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22843,0,'','',10074,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22844,0,'','',10074,'Context switches per second','system.cpu.switches',60,7,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22845,0,'','',10074,'CPU $2 time','system.cpu.util[,idle]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30',0,0,0,''),(22846,0,'','',10074,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The amount of time the CPU has been servicing hardware interrupts.',0,'30',0,0,0,''),(22848,0,'','',10074,'CPU $2 time','system.cpu.util[,nice]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that have been niced.',0,'30',0,0,0,''),(22851,0,'','',10074,'CPU $2 time','system.cpu.util[,system]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30',0,0,0,''),(22852,0,'','',10074,'CPU $2 time','system.cpu.util[,user]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30',0,0,0,''),(22853,0,'','',10074,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','System host name.',3,'30',0,0,0,''),(22854,0,'','',10074,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22855,0,'','',10074,'Free swap space','system.swap.size[,free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22856,0,'','',10074,'Free swap space in %','system.swap.size[,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22857,0,'','',10074,'Total swap space','system.swap.size[,total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22858,0,'','',10074,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30',0,0,0,''),(22859,0,'','',10074,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22860,0,'','',10074,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of users who are currently logged in.',0,'30',0,0,0,''),(22861,0,'','',10074,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22862,0,'','',10074,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30',0,0,0,''),(22863,0,'','',10074,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22867,0,'','',10074,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(22868,0,'','',10074,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22869,0,'','',10074,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22870,0,'','',10074,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22871,0,'','',10074,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22872,0,'','',10074,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22873,0,'','',10075,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(22874,0,'','',10075,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22875,0,'','',10075,'Maximum number of opened files','kernel.maxfiles',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30',0,0,0,''),(22876,0,'','',10075,'Maximum number of processes','kernel.maxproc',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30',0,0,0,''),(22877,0,'','',10075,'Number of running processes','proc.num[,,run]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of processes in running state.',0,'30',0,0,0,''),(22878,0,'','',10075,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Total number of processes in any state.',0,'30',0,0,0,''),(22879,0,'','',10075,'Host boot time','system.boottime',600,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22880,0,'','',10075,'Interrupts per second','system.cpu.intr',60,7,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22881,0,'','',10075,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22882,0,'','',10075,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22883,0,'','',10075,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22884,0,'','',10075,'Context switches per second','system.cpu.switches',60,7,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22885,0,'','',10075,'CPU $2 time','system.cpu.util[,idle]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30',0,0,0,''),(22886,0,'','',10075,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The amount of time the CPU has been servicing hardware interrupts.',0,'30',0,0,0,''),(22888,0,'','',10075,'CPU $2 time','system.cpu.util[,nice]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that have been niced.',0,'30',0,0,0,''),(22891,0,'','',10075,'CPU $2 time','system.cpu.util[,system]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30',0,0,0,''),(22892,0,'','',10075,'CPU $2 time','system.cpu.util[,user]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30',0,0,0,''),(22893,0,'','',10075,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','System host name.',3,'30',0,0,0,''),(22894,0,'','',10075,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22895,0,'','',10075,'Free swap space','system.swap.size[,free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22896,0,'','',10075,'Free swap space in %','system.swap.size[,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22897,0,'','',10075,'Total swap space','system.swap.size[,total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22898,0,'','',10075,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30',0,0,0,''),(22899,0,'','',10075,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22900,0,'','',10075,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of users who are currently logged in.',0,'30',0,0,0,''),(22901,0,'','',10075,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22902,0,'','',10075,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30',0,0,0,''),(22903,0,'','',10075,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22907,0,'','',10075,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(22908,0,'','',10075,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22909,0,'','',10075,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22910,0,'','',10075,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22911,0,'','',10075,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22912,0,'','',10075,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22913,0,'','',10076,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(22914,0,'','',10076,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22917,0,'','',10076,'Number of running processes','proc.num[,,run]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of processes in running state.',0,'30',0,0,0,''),(22918,0,'','',10076,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Total number of processes in any state.',0,'30',0,0,0,''),(22920,0,'','',10076,'Interrupts per second','system.cpu.intr',60,7,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22921,0,'','',10076,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22922,0,'','',10076,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22923,0,'','',10076,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22924,0,'','',10076,'Context switches per second','system.cpu.switches',60,7,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22933,0,'','',10076,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','System host name.',3,'30',0,0,0,''),(22934,0,'','',10076,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22938,0,'','',10076,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30',0,0,0,''),(22939,0,'','',10076,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22940,0,'','',10076,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of users who are currently logged in.',0,'30',0,0,0,''),(22941,0,'','',10076,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22942,0,'','',10076,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30',0,0,0,''),(22943,0,'','',10076,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22944,0,'','',10076,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(22945,0,'','',10076,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22946,0,'','',10076,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22947,0,'','',10076,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(22948,0,'','',10076,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22949,0,'','',10076,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22950,0,'','',10076,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22951,0,'','',10076,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22952,0,'','',10076,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22953,0,'','',10077,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(22954,0,'','',10077,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22961,0,'','',10077,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22962,0,'','',10077,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22963,0,'','',10077,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(22965,0,'','',10077,'CPU $2 time','system.cpu.util[,idle]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30',0,0,0,''),(22968,0,'','',10077,'CPU $2 time','system.cpu.util[,nice]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that have been niced.',0,'30',0,0,0,''),(22971,0,'','',10077,'CPU $2 time','system.cpu.util[,system]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30',0,0,0,''),(22972,0,'','',10077,'CPU $2 time','system.cpu.util[,user]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30',0,0,0,''),(22973,0,'','',10077,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','System host name.',3,'30',0,0,0,''),(22974,0,'','',10077,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22978,0,'','',10077,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30',0,0,0,''),(22980,0,'','',10077,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of users who are currently logged in.',0,'30',0,0,0,''),(22981,0,'','',10077,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22982,0,'','',10077,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30',0,0,0,''),(22983,0,'','',10077,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(22984,0,'','',10077,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(22985,0,'','',10077,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22986,0,'','',10077,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22987,0,'','',10077,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(22988,0,'','',10077,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22989,0,'','',10077,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22990,0,'','',10077,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22991,0,'','',10077,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22992,0,'','',10077,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(22993,0,'','',10078,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(22994,0,'','',10078,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(22996,0,'','',10078,'Maximum number of processes','kernel.maxproc',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30',0,0,0,''),(22997,0,'','',10078,'Number of running processes','proc.num[,,run]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of processes in running state.',0,'30',0,0,0,''),(22998,0,'','',10078,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Total number of processes in any state.',0,'30',0,0,0,''),(22999,0,'','',10078,'Host boot time','system.boottime',600,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23000,0,'','',10078,'Interrupts per second','system.cpu.intr',60,7,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23001,0,'','',10078,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(23002,0,'','',10078,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(23003,0,'','',10078,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(23004,0,'','',10078,'Context switches per second','system.cpu.switches',60,7,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23005,0,'','',10078,'CPU $2 time','system.cpu.util[,idle]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent doing nothing.',0,'30',0,0,0,''),(23007,0,'','',10078,'CPU $2 time','system.cpu.util[,iowait]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Amount of time the CPU has been waiting for I/O to complete.',0,'30',0,0,0,''),(23011,0,'','',10078,'CPU $2 time','system.cpu.util[,system]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running the kernel and its processes.',0,'30',0,0,0,''),(23012,0,'','',10078,'CPU $2 time','system.cpu.util[,user]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The time the CPU has spent running users\' processes that are not niced.',0,'30',0,0,0,''),(23013,0,'','',10078,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','System host name.',3,'30',0,0,0,''),(23014,0,'','',10078,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23015,0,'','',10078,'Free swap space','system.swap.size[,free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23016,0,'','',10078,'Free swap space in %','system.swap.size[,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23017,0,'','',10078,'Total swap space','system.swap.size[,total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23018,0,'','',10078,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30',0,0,0,''),(23019,0,'','',10078,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23020,0,'','',10078,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of users who are currently logged in.',0,'30',0,0,0,''),(23021,0,'','',10078,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23022,0,'','',10078,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30',0,0,0,''),(23023,0,'','',10078,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23024,0,'','',10078,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(23025,0,'','',10078,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23026,0,'','',10078,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23027,0,'','',10078,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(23028,0,'','',10078,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23029,0,'','',10078,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23030,0,'','',10078,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23031,0,'','',10078,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23032,0,'','',10078,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23033,0,'','',10079,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(23034,0,'','',10079,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23035,0,'','',10079,'Maximum number of opened files','kernel.maxfiles',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30',0,0,0,''),(23036,0,'','',10079,'Maximum number of processes','kernel.maxproc',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'30',0,0,0,''),(23039,0,'','',10079,'Host boot time','system.boottime',600,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23041,0,'','',10079,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(23042,0,'','',10079,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(23043,0,'','',10079,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'30',0,0,0,''),(23053,0,'','',10079,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','System host name.',3,'30',0,0,0,''),(23054,0,'','',10079,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23058,0,'','',10079,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','The information as normally returned by \'uname -a\'.',5,'30',0,0,0,''),(23059,0,'','',10079,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23060,0,'','',10079,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Number of users who are currently logged in.',0,'30',0,0,0,''),(23061,0,'','',10079,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23062,0,'','',10079,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Available memory is defined as free+cached+buffers memory.',0,'30',0,0,0,''),(23063,0,'','',10079,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23067,0,'','',10079,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(23068,0,'','',10079,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23069,0,'','',10079,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23070,0,'','',10079,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23071,0,'','',10079,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23072,0,'','',10079,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23073,0,'','',10075,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23074,0,'','',10075,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23075,0,'','',10074,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23076,0,'','',10074,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'0',0,0,0,''),(23077,0,'','',10079,'Incoming network traffic on $1','net.if.in[en0]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23078,0,'','',10079,'Outgoing network traffic on $1','net.if.out[en0]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23108,0,'','',10076,'CPU available physical processors in the shared pool','system.stat[cpu,app]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23109,0,'','',10076,'CPU entitled capacity consumed','system.stat[cpu,ec]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23110,0,'','',10076,'CPU idle time','system.stat[cpu,id]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23111,0,'','',10076,'CPU logical processor utilization','system.stat[cpu,lbusy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23112,0,'','',10076,'CPU number of physical processors consumed','system.stat[cpu,pc]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23113,0,'','',10076,'CPU system time','system.stat[cpu,sy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23114,0,'','',10076,'CPU user time','system.stat[cpu,us]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23115,0,'','',10076,'CPU iowait time','system.stat[cpu,wa]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23116,0,'','',10076,'Amount of data transferred','system.stat[disk,bps]',60,7,365,0,0,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23117,0,'','',10076,'Number of transfers','system.stat[disk,tps]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23118,0,'','',10076,'Processor units is entitled to receive','system.stat[ent]',3600,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23119,0,'','',10076,'Kernel thread context switches','system.stat[faults,cs]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23120,0,'','',10076,'Device interrupts','system.stat[faults,in]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23121,0,'','',10076,'System calls','system.stat[faults,sy]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23122,0,'','',10076,'Length of the swap queue','system.stat[kthr,b]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23123,0,'','',10076,'Length of the run queue','system.stat[kthr,r]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23124,0,'','',10076,'Active virtual pages','system.stat[memory,avm]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23125,0,'','',10076,'Free real memory','system.stat[memory,fre]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23126,0,'','',10076,'File page-ins per second','system.stat[page,fi]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23127,0,'','',10076,'File page-outs per second','system.stat[page,fo]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23128,0,'','',10076,'Pages freed (page replacement)','system.stat[page,fr]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23129,0,'','',10076,'Pages paged in from paging space','system.stat[page,pi]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23130,0,'','',10076,'Pages paged out to paging space','system.stat[page,po]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23131,0,'','',10076,'Pages scanned by page-replacement algorithm','system.stat[page,sr]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23134,0,'','',10081,'Average disk read queue length','perf_counter[\\234(_Total)\\1402]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Full counter name: \\PhysicalDisk(_Total)\\Avg. Disk Read Queue Length',0,'30',0,0,0,''),(23135,0,'','',10081,'Average disk write queue length','perf_counter[\\234(_Total)\\1404]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Full counter name: \\PhysicalDisk(_Total)\\Avg. Disk Write Queue Length',0,'30',0,0,0,''),(23136,0,'','',10081,'File read bytes per second','perf_counter[\\2\\16]',60,7,365,0,0,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Full counter name: \\System\\File Read Bytes/sec',0,'30',0,0,0,''),(23137,0,'','',10081,'File write bytes per second','perf_counter[\\2\\18]',60,7,365,0,0,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Full counter name: \\System\\File Write Bytes/sec',0,'30',0,0,0,''),(23138,0,'','',10081,'Number of threads','perf_counter[\\2\\250]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','Full counter name: \\System\\Threads',0,'30',0,0,0,''),(23140,0,'','',10081,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23143,0,'','',10081,'Processor load (1 min average)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23144,0,'','',10081,'Processor load (15 min average)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23145,0,'','',10081,'Processor load (5 min average)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23147,0,'','',10081,'Free swap space','system.swap.size[,free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23148,0,'','',10081,'Total swap space','system.swap.size[,total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23149,0,'','',10081,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',5,'30',0,0,0,''),(23150,0,'','',10081,'System uptime','system.uptime',60,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23158,0,'','',10081,'Free memory','vm.memory.size[free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23159,0,'','',10081,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23160,0,'','',10081,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22232,10,'','','',0,0,'','','','',0,0,'',NULL,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(23161,0,'','',10081,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',22231,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23162,0,'','',10081,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',NULL,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(23163,0,'','',10081,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(23164,0,'','',10081,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23165,0,'','',10081,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23167,0,'','',10081,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23168,0,'','',10081,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23169,0,'','',10081,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23170,0,'','',10081,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',NULL,NULL,'','','',0,0,'','','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23171,5,'','',10047,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23172,16,'','',10082,'comp Accumulated time spent in compilation','jmx[\"java.lang:type=Compilation\",TotalCompilationTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23173,16,'','',10082,'cl Loaded Class Count','jmx[\"java.lang:type=ClassLoading\",LoadedClassCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23174,16,'','',10082,'cl Total Loaded Class Count','jmx[\"java.lang:type=ClassLoading\",TotalLoadedClassCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23175,16,'','',10082,'cl Unloaded Class Count','jmx[\"java.lang:type=ClassLoading\",UnloadedClassCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23176,16,'','',10082,'gc ConcurrentMarkSweep accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=ConcurrentMarkSweep\",CollectionTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23177,16,'','',10082,'gc ConcurrentMarkSweep number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=ConcurrentMarkSweep\",CollectionCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23178,16,'','',10082,'gc Copy accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=Copy\",CollectionTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23179,16,'','',10082,'gc Copy number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=Copy\",CollectionCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23180,16,'','',10082,'gc MarkSweepCompact accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=MarkSweepCompact\",CollectionTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23181,16,'','',10082,'gc MarkSweepCompact number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=MarkSweepCompact\",CollectionCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23182,16,'','',10082,'gc ParNew accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=ParNew\",CollectionTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23183,16,'','',10082,'gc ParNew number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=ParNew\",CollectionCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23184,16,'','',10082,'gc PS MarkSweep accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=PS MarkSweep\",CollectionTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23185,16,'','',10082,'gc PS Scavenge accumulated time spent in collection','jmx[\"java.lang:type=GarbageCollector,name=PS Scavenge\",CollectionTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23186,16,'','',10082,'gc PS Scavenge number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=PS Scavenge\",CollectionCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23187,16,'','',10082,'gc PS MarkSweep number of collections per second','jmx[\"java.lang:type=GarbageCollector,name=PS MarkSweep\",CollectionCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23188,16,'','',10082,'jvm Uptime','jmx[\"java.lang:type=Runtime\",Uptime]',60,7,365,0,3,'','uptime',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23189,16,'','',10082,'jvm Version','jmx[\"java.lang:type=Runtime\",VmVersion]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23190,16,'','',10082,'mem Object Pending Finalization Count','jmx[\"java.lang:type=Memory\",ObjectPendingFinalizationCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23191,16,'','',10082,'mp CMS Old Gen committed','jmx[\"java.lang:type=MemoryPool,name=CMS Old Gen\",Usage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23192,16,'','',10082,'mp CMS Old Gen max','jmx[\"java.lang:type=MemoryPool,name=CMS Old Gen\",Usage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23193,16,'','',10082,'mp CMS Old Gen used','jmx[\"java.lang:type=MemoryPool,name=CMS Old Gen\",Usage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23194,16,'','',10082,'mp CMS Perm Gen committed','jmx[\"java.lang:type=MemoryPool,name=CMS Perm Gen\",Usage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23195,16,'','',10082,'mp CMS Perm Gen max','jmx[\"java.lang:type=MemoryPool,name=CMS Perm Gen\",Usage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23196,16,'','',10082,'mp CMS Perm Gen used','jmx[\"java.lang:type=MemoryPool,name=CMS Perm Gen\",Usage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23197,16,'','',10082,'mp Code Cache committed','jmx[\"java.lang:type=MemoryPool,name=Code Cache\",Usage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23198,16,'','',10082,'mp Code Cache max','jmx[\"java.lang:type=MemoryPool,name=Code Cache\",Usage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23199,16,'','',10082,'mp Code Cache used','jmx[\"java.lang:type=MemoryPool,name=Code Cache\",Usage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23200,16,'','',10082,'mp Perm Gen committed','jmx[\"java.lang:type=MemoryPool,name=Perm Gen\",Usage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23201,16,'','',10082,'mp Perm Gen max','jmx[\"java.lang:type=MemoryPool,name=Perm Gen\",Usage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23202,16,'','',10082,'mp Perm Gen used','jmx[\"java.lang:type=MemoryPool,name=Perm Gen\",Usage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23203,16,'','',10082,'mp PS Old Gen committed','jmx[\"java.lang:type=MemoryPool,name=PS Old Gen\",Usage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23204,16,'','',10082,'mp PS Old Gen max','jmx[\"java.lang:type=MemoryPool,name=PS Old Gen\",Usage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23205,16,'','',10082,'mp PS Old Gen used','jmx[\"java.lang:type=MemoryPool,name=PS Old Gen\",Usage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23206,16,'','',10082,'mp PS Perm Gen committed','jmx[\"java.lang:type=MemoryPool,name=PS Perm Gen\",Usage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23207,16,'','',10082,'mp PS Perm Gen max','jmx[\"java.lang:type=MemoryPool,name=PS Perm Gen\",Usage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23208,16,'','',10082,'mp PS Perm Gen used','jmx[\"java.lang:type=MemoryPool,name=PS Perm Gen\",Usage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23209,16,'','',10082,'mp Tenured Gen committed','jmx[\"java.lang:type=MemoryPool,name=Tenured Gen\",Usage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23210,16,'','',10082,'mp Tenured Gen max','jmx[\"java.lang:type=MemoryPool,name=Tenured Gen\",Usage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23211,16,'','',10082,'mp Tenured Gen used','jmx[\"java.lang:type=MemoryPool,name=Tenured Gen\",Usage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23212,16,'','',10082,'comp Name of the current JIT compiler','jmx[\"java.lang:type=Compilation\",Name]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23213,16,'','',10082,'os Max File Descriptor Count','jmx[\"java.lang:type=OperatingSystem\",MaxFileDescriptorCount]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23214,16,'','',10082,'os Open File Descriptor Count','jmx[\"java.lang:type=OperatingSystem\",OpenFileDescriptorCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23215,16,'','',10082,'th Daemon Thread Count','jmx[\"java.lang:type=Threading\",DaemonThreadCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23216,16,'','',10082,'th Peak Thread Count','jmx[\"java.lang:type=Threading\",PeakThreadCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23217,16,'','',10082,'th Thread Count','jmx[\"java.lang:type=Threading\",ThreadCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23218,16,'','',10082,'th Total Started Thread Count','jmx[\"java.lang:type=Threading\",TotalStartedThreadCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23219,16,'','',10083,'http-8080 bytes received per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",bytesReceived]',60,7,365,0,0,'','B',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23220,16,'','',10083,'http-8080 bytes sent per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",bytesSent]',60,7,365,0,0,'','B',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23221,16,'','',10083,'http-8080 errors per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",errorCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23222,16,'','',10083,'http-8080 gzip compression','jmx[\"Catalina:type=ProtocolHandler,port=8080\",compression]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23223,16,'','',10083,'http-8080 request processing time','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",processingTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23224,16,'','',10083,'http-8080 requests per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8080\",requestCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23225,16,'','',10083,'http-8080 threads allocated','jmx[\"Catalina:type=ThreadPool,name=http-8080\",currentThreadCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23226,16,'','',10083,'http-8080 threads busy','jmx[\"Catalina:type=ThreadPool,name=http-8080\",currentThreadsBusy]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23227,16,'','',10083,'http-8080 threads max','jmx[\"Catalina:type=ThreadPool,name=http-8080\",maxThreads]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23228,16,'','',10083,'http-8443 bytes received per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",bytesReceived]',60,7,365,0,0,'','B',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23229,16,'','',10083,'http-8443 bytes sent per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\", bytesSent]',60,7,365,0,0,'','B',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23230,16,'','',10083,'http-8443 errors per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",errorCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23231,16,'','',10083,'http-8443 gzip compression','jmx[\"Catalina:type=ProtocolHandler,port=8443\",compression]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23232,16,'','',10083,'http-8443 request processing time','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",processingTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23233,16,'','',10083,'http-8443 requests per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=http-8443\",requestCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23234,16,'','',10083,'http-8443 threads allocated','jmx[\"Catalina:type=ThreadPool,name=http-8443\",currentThreadCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23235,16,'','',10083,'http-8443 threads busy','jmx[\"Catalina:type=ThreadPool,name=http-8443\",currentThreadsBusy]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23236,16,'','',10083,'http-8443 threads max','jmx[\"Catalina:type=ThreadPool,name=http-8443\",maxThreads]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23237,16,'','',10083,'jk-8009 bytes received per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\", bytesReceived]',60,7,365,0,0,'','B',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23238,16,'','',10083,'jk-8009 bytes sent per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",bytesSent]',60,7,365,0,0,'','B',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23239,16,'','',10083,'jk-8009 errors per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",errorCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23240,16,'','',10083,'jk-8009 request processing time','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",processingTime]',60,7,365,0,0,'','s',1,0,'',0,'','','0.001','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23241,16,'','',10083,'jk-8009 requests per second','jmx[\"Catalina:type=GlobalRequestProcessor,name=jk-8009\",requestCount]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23242,16,'','',10083,'jk-8009 threads allocated','jmx[\"Catalina:type=ThreadPool,name=jk-8009\",currentThreadCount]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23243,16,'','',10083,'jk-8009 threads busy','jmx[\"Catalina:type=ThreadPool,name=jk-8009\",currentThreadsBusy]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23244,16,'','',10083,'jk-8009 threads max','jmx[\"Catalina:type=ThreadPool,name=jk-8009\",maxThreads]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23245,16,'','',10083,'Maximum number of active sessions so far','jmx[\"Catalina:type=Manager,path=/,host=localhost\",maxActive]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23246,16,'','',10083,'Number of active sessions at this moment','jmx[\"Catalina:type=Manager,path=/,host=localhost\",activeSessions]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23247,16,'','',10083,'Number of sessions created by this manager per second','jmx[\"Catalina:type=Manager,path=/,host=localhost\",sessionCounter]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23248,16,'','',10083,'Number of sessions we rejected due to maxActive being reached','jmx[\"Catalina:type=Manager,path=/,host=localhost\",rejectedSessions]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23249,16,'','',10083,'The maximum number of active Sessions allowed, or -1 for no limit','jmx[\"Catalina:type=Manager,path=/,host=localhost\",maxActiveSessions]',3600,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23250,16,'','',10083,'Tomcat version','jmx[\"Catalina:type=Server\",serverInfo]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23251,5,'','',10047,'Zabbix queue','zabbix[queue]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23252,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,alerter,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22424,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23253,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22412,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23254,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,db watchdog,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22410,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23255,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22430,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23256,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,escalator,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22422,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23257,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22406,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23258,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22408,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23259,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22402,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23260,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22418,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23261,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22416,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23262,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22689,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23263,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,node watcher,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22428,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23264,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22399,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23265,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,proxy poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22420,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23266,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22414,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23267,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',23171,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23268,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,timer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22426,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23269,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22404,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23270,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22400,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23271,5,'','',10084,'Zabbix queue over $2','zabbix[queue,10m]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',22219,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23272,5,'','',10084,'Zabbix queue','zabbix[queue]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',23251,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23273,5,'','',10084,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22189,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23274,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22183,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23275,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,text,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22396,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23276,5,'','',10084,'Zabbix $2 write cache, % free','zabbix[wcache,trend,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22185,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23277,5,'','',10084,'Values processed by Zabbix server per second','zabbix[wcache,values]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',22187,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23278,0,'','',10084,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22444,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',1,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(23279,0,'','',10084,'Mounted filesystem discovery','vfs.fs.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',22450,NULL,'','','',0,0,'','','','',0,1,'{#FSTYPE}:@File systems for discovery',1,'','Discovery of file systems of different types as defined in global regular expression \"File systems for discovery\".',0,'30',0,0,0,''),(23280,0,'','',10084,'Incoming network traffic on $1','net.if.in[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22446,NULL,'','','',0,0,'','','','',0,2,'',1,'','',0,'0',0,0,0,''),(23281,0,'','',10084,'Outgoing network traffic on $1','net.if.out[{#IFNAME}]',60,7,365,0,3,'','bps',1,1,'',0,'','','8','',0,'',22448,NULL,'','','',0,0,'','','','',0,2,'',1,'','',0,'0',0,0,0,''),(23282,0,'','',10084,'Free inodes on $1 (percentage)','vfs.fs.inode[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22454,NULL,'','','',0,0,'','','','',0,2,'',1,'','',0,'0',0,0,0,''),(23283,0,'','',10084,'Free disk space on $1','vfs.fs.size[{#FSNAME},free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22452,NULL,'','','',0,0,'','','','',0,2,'',1,'','',0,'0',0,0,0,''),(23284,0,'','',10084,'Free disk space on $1 (percentage)','vfs.fs.size[{#FSNAME},pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22686,NULL,'','','',0,0,'','','','',0,2,'',1,'','',0,'0',0,0,0,''),(23285,0,'','',10084,'Total disk space on $1','vfs.fs.size[{#FSNAME},total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22456,NULL,'','','',0,0,'','','','',0,2,'',1,'','',0,'0',0,0,0,''),(23286,0,'','',10084,'Used disk space on $1','vfs.fs.size[{#FSNAME},used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22458,NULL,'','','',0,0,'','','','',0,2,'',1,'','',0,'0',0,0,0,''),(23287,0,'','',10084,'Agent ping','agent.ping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',10020,10,'','','',0,0,'','','','',0,0,'',1,'','The agent always returns 1 for this item. It could be used in combination with nodata() for availability check.',0,'0',0,0,0,''),(23288,0,'','',10084,'Version of zabbix_agent(d) running','agent.version',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',10059,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23289,0,'','',10084,'Maximum number of opened files','kernel.maxfiles',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',10056,NULL,'','','',0,0,'','','','',0,0,'',1,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0',0,0,0,''),(23290,0,'','',10084,'Maximum number of processes','kernel.maxproc',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',10055,NULL,'','','',0,0,'','','','',0,0,'',1,'','It could be increased by using sysctrl utility or modifying file /etc/sysctl.conf.',0,'0',0,0,0,''),(23291,0,'','',10084,'Number of running processes','proc.num[,,run]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',10013,NULL,'','','',0,0,'','','','',0,0,'',1,'','Number of processes in running state.',0,'0',0,0,0,''),(23292,0,'','',10084,'Number of processes','proc.num[]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',10009,NULL,'','','',0,0,'','','','',0,0,'',1,'','Total number of processes in any state.',0,'0',0,0,0,''),(23293,0,'','',10084,'Host boot time','system.boottime',600,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',17318,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23294,0,'','',10084,'Interrupts per second','system.cpu.intr',60,7,365,0,3,'','ips',0,1,'',0,'','','1','',0,'',22683,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23295,0,'','',10084,'Processor load (15 min average per core)','system.cpu.load[percpu,avg15]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',22677,NULL,'','','',0,0,'','','','',0,0,'',1,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,''),(23296,0,'','',10084,'Processor load (1 min average per core)','system.cpu.load[percpu,avg1]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',10010,NULL,'','','',0,0,'','','','',0,0,'',1,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,''),(23297,0,'','',10084,'Processor load (5 min average per core)','system.cpu.load[percpu,avg5]',60,7,365,0,0,'','',0,0,'',0,'','','1','',0,'',22674,NULL,'','','',0,0,'','','','',0,0,'',1,'','The processor load is calculated as system CPU load divided by number of CPU cores.',0,'0',0,0,0,''),(23298,0,'','',10084,'Context switches per second','system.cpu.switches',60,7,365,0,3,'','sps',0,1,'',0,'','','1','',0,'',22680,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23299,0,'','',10084,'CPU $2 time','system.cpu.util[,idle]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',17354,NULL,'','','',0,0,'','','','',0,0,'',1,'','The time the CPU has spent doing nothing.',0,'0',0,0,0,''),(23300,0,'','',10084,'CPU $2 time','system.cpu.util[,interrupt]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22671,NULL,'','','',0,0,'','','','',0,0,'',1,'','The amount of time the CPU has been servicing hardware interrupts.',0,'0',0,0,0,''),(23301,0,'','',10084,'CPU $2 time','system.cpu.util[,iowait]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',17362,NULL,'','','',0,0,'','','','',0,0,'',1,'','Amount of time the CPU has been waiting for I/O to complete.',0,'0',0,0,0,''),(23302,0,'','',10084,'CPU $2 time','system.cpu.util[,nice]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',17358,NULL,'','','',0,0,'','','','',0,0,'',1,'','The time the CPU has spent running users\' processes that have been niced.',0,'0',0,0,0,''),(23303,0,'','',10084,'CPU $2 time','system.cpu.util[,softirq]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22668,NULL,'','','',0,0,'','','','',0,0,'',1,'','The amount of time the CPU has been servicing software interrupts.',0,'0',0,0,0,''),(23304,0,'','',10084,'CPU $2 time','system.cpu.util[,steal]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22665,NULL,'','','',0,0,'','','','',0,0,'',1,'','The amount of CPU \'stolen\' from this virtual machine by the hypervisor for other tasks (such as running another virtual machine).',0,'0',0,0,0,''),(23305,0,'','',10084,'CPU $2 time','system.cpu.util[,system]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',17360,NULL,'','','',0,0,'','','','',0,0,'',1,'','The time the CPU has spent running the kernel and its processes.',0,'0',0,0,0,''),(23306,0,'','',10084,'CPU $2 time','system.cpu.util[,user]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',17356,NULL,'','','',0,0,'','','','',0,0,'',1,'','The time the CPU has spent running users\' processes that are not niced.',0,'0',0,0,0,''),(23307,0,'','',10084,'Host name','system.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',10057,NULL,'','','',0,0,'','','','',0,0,'',1,'','System host name.',3,'0',0,0,0,''),(23308,0,'','',10084,'Host local time','system.localtime',60,7,365,0,3,'','unixtime',0,0,'',0,'','','1','',0,'',17352,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23309,0,'','',10084,'Free swap space','system.swap.size[,free]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',10014,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23310,0,'','',10084,'Free swap space in %','system.swap.size[,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',17350,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23311,0,'','',10084,'Total swap space','system.swap.size[,total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',10030,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23312,0,'','',10084,'System information','system.uname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',10058,NULL,'','','',0,0,'','','','',0,0,'',1,'','The information as normally returned by \'uname -a\'.',5,'0',0,0,0,''),(23313,0,'','',10084,'System uptime','system.uptime',600,7,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',10025,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23314,0,'','',10084,'Number of logged in users','system.users.num',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',10016,NULL,'','','',0,0,'','','','',0,0,'',1,'','Number of users who are currently logged in.',0,'0',0,0,0,''),(23315,0,'','',10084,'Checksum of $1','vfs.file.cksum[/etc/passwd]',3600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',10019,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23316,0,'','',10084,'Available memory','vm.memory.size[available]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',22181,NULL,'','','',0,0,'','','','',0,0,'',1,'','Available memory is defined as free+cached+buffers memory.',0,'0',0,0,0,''),(23317,0,'','',10084,'Total memory','vm.memory.size[total]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',10026,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'0',0,0,0,''),(23318,0,'','',10050,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23319,0,'','',10001,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23320,0,'','',10074,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23321,0,'','',10075,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23322,0,'','',10076,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23323,0,'','',10077,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23324,0,'','',10078,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23325,0,'','',10079,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23326,0,'','',10081,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23318,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23327,0,'','',10084,'Host name of zabbix_agentd running','agent.hostname',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',23319,NULL,'','','',0,0,'','','','',0,0,'',1,'','',0,'30',0,0,0,''),(23328,5,'','',10084,'Zabbix $4 $2 processes, in %','zabbix[process,vmware collector,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22401,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23329,0,'','',10074,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(23340,5,'','',10048,'Values processed by Zabbix proxy per second','zabbix[wcache,values]',60,7,365,0,0,'','',0,1,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23341,5,'','',10048,'Zabbix $2 write cache, % free','zabbix[wcache,text,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23342,5,'','',10048,'Zabbix $2 write cache, % free','zabbix[wcache,history,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23343,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,self-monitoring,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23344,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,snmp trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23345,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,trapper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23346,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,unreachable poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23347,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,configuration syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23348,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,poller,avg,busy]',60,7,365,0,0,'localhost','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23349,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,java poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23350,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,history syncer,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23351,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,heartbeat sender,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23352,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,discoverer,avg,busy]',60,7,365,0,0,'localhost','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23353,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,housekeeper,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23354,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,http poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23355,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,ipmi poller,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23356,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,icmp pinger,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23357,5,'','',10048,'Zabbix configuration cache, % free','zabbix[rcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23358,5,'','',10048,'Zabbix queue','zabbix[queue]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23359,5,'','',10048,'Zabbix queue over $2','zabbix[queue,10m]',600,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23360,5,'','',10048,'Zabbix $4 $2 processes, in %','zabbix[process,data sender,avg,busy]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23540,0,'','',10075,'Network interface discovery','net.if.discovery',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,1,'{#IFNAME}:@Network interfaces for discovery',NULL,'','Discovery of network interfaces as defined in global regular expression \"Network interfaces for discovery\".',0,'30',0,0,0,''),(23542,3,'','',10088,'Discover VMware VMs','vmware.vm.discovery[{$URL}]',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,':',NULL,'','Discovery of guest virtual machines.',0,'30',0,0,0,''),(23543,3,'','',10089,'Ballooned memory','vmware.vm.memory.size.ballooned[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The amount of guest physical memory that is currently reclaimed through the balloon driver.',0,'30',0,0,0,''),(23544,3,'','',10089,'Compressed memory','vmware.vm.memory.size.compressed[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The amount of memory currently in the compression cache for this VM.',0,'30',0,0,0,''),(23545,3,'','',10089,'Memory size','vmware.vm.memory.size[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Total size of configured memory.',0,'30',0,0,0,''),(23546,3,'','',10089,'Swapped memory','vmware.vm.memory.size.swapped[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The amount of guest physical memory swapped out to the VM\'s swap device by ESX.',0,'30',0,0,0,''),(23547,3,'','',10089,'Committed storage space','vmware.vm.storage.committed[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Total storage space, in bytes, committed to this virtual machine across all datastores.',0,'30',0,0,0,''),(23548,3,'','',10089,'Uncommitted storage space','vmware.vm.storage.uncommitted[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Additional storage space, in bytes, potentially used by this virtual machine on all datastores.',0,'30',0,0,0,''),(23549,3,'','',10089,'Unshared storage space','vmware.vm.storage.unshared[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Total storage space, in bytes, occupied by the virtual machine across all datastores, that is not shared with any other virtual machine.',0,'30',0,0,0,''),(23550,3,'','',10089,'CPU usage','vmware.vm.cpu.usage[{$URL},{HOST.HOST}]',60,90,365,0,3,'','Hz',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Current upper-bound on CPU usage. The upper-bound is based on the host the virtual machine is current running on, as well as limits configured on the virtual machine itself or any parent resource pool. Valid while the virtual machine is running.',0,'30',0,0,0,''),(23551,3,'','',10089,'Number of virtual CPUs','vmware.vm.cpu.num[{$URL},{HOST.HOST}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Number of virtual CPUs assigned to the guest.',0,'30',0,0,0,''),(23552,3,'','',10089,'Power state','vmware.vm.powerstate[{$URL},{HOST.HOST}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,12,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The current power state of the virtual machine.',0,'30',0,0,0,''),(23553,3,'','',10089,'Uptime','vmware.vm.uptime[{$URL},{HOST.HOST}]',60,90,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','System uptime.',0,'30',0,0,0,''),(23554,3,'','',10088,'Discover VMware hypervisors','vmware.hv.discovery[{$URL}]',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,':',NULL,'','Discovery of hypervisors.',0,'30',0,0,0,''),(23555,3,'','',10091,'Bios UUID','vmware.hv.hw.uuid[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The hardware BIOS identification.',0,'30',0,0,0,''),(23556,3,'','',10091,'CPU cores','vmware.hv.hw.cpu.num[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Number of physical CPU cores on the host. Physical CPU cores are the processors contained by a CPU package.',0,'30',0,0,0,''),(23557,3,'','',10091,'CPU frequency','vmware.hv.hw.cpu.freq[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','Hz',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The speed of the CPU cores. This is an average value if there are multiple speeds. The product of CPU frequency and number of cores is approximately equal to the sum of the MHz for all the individual cores on the host.',0,'30',0,0,0,''),(23558,3,'','',10091,'CPU model','vmware.hv.hw.cpu.model[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The CPU model.',0,'30',0,0,0,''),(23559,3,'','',10091,'CPU threads','vmware.hv.hw.cpu.threads[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Number of physical CPU threads on the host.',0,'30',0,0,0,''),(23560,3,'','',10091,'CPU usage','vmware.hv.cpu.usage[{$URL},{HOST.HOST}]',60,90,365,0,3,'','Hz',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Aggregated CPU usage across all cores on the host in Hz. This is only available if the host is connected.',0,'30',0,0,0,''),(23561,3,'','',10091,'Full name','vmware.hv.fullname[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The complete product name, including the version information.',0,'30',0,0,0,''),(23562,3,'','',10091,'Model','vmware.hv.hw.model[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The system model identification.',0,'30',0,0,0,''),(23563,3,'','',10091,'Overall status','vmware.hv.status[{$URL},{HOST.HOST}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,13,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The overall alarm status of the host: gray - unknown, ok, red - it has a problem, yellow - it might have a problem.',0,'30',0,0,0,''),(23564,3,'','',10091,'Total memory','vmware.hv.hw.memory[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The physical memory size.',0,'30',0,0,0,''),(23565,3,'','',10091,'Uptime','vmware.hv.uptime[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','uptime',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','System uptime.',0,'30',0,0,0,''),(23566,3,'','',10091,'Used memory','vmware.hv.memory.used[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Physical memory usage on the host.',0,'30',0,0,0,''),(23567,3,'','',10091,'Vendor','vmware.hv.hw.vendor[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The hardware vendor identification.',0,'30',0,0,0,''),(23568,3,'','',10091,'Version','vmware.hv.version[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Dot-separated version string.',0,'30',0,0,0,''),(23569,3,'','',10091,'Number of guest VMs','vmware.hv.vm.num[{$URL},{HOST.HOST}]',3600,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Number of guest virtual machines.',0,'30',0,0,0,''),(23572,3,'','',10091,'Ballooned memory','vmware.hv.memory.size.ballooned[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The amount of guest physical memory that is currently reclaimed through the balloon driver. Sum of all guest VMs.',0,'30',0,0,0,''),(23573,3,'','',10089,'Hypervisor name','vmware.vm.hv.name[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Hypervisor name of the guest VM.',0,'30',0,0,0,''),(23575,3,'','',10089,'Mounted filesystem discovery','vmware.vm.vfs.fs.discovery[{$URL},{HOST.HOST}]',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,':',NULL,'','Discovery of all guest file systems.',0,'30',0,0,0,''),(23576,3,'','',10089,'Free disk space on {#FSNAME}','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},free]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23577,3,'','',10089,'Free disk space on {#FSNAME} (percentage)','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},pfree]',60,90,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23578,3,'','',10089,'Total disk space on {#FSNAME}','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},total]',3600,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23579,3,'','',10089,'Used disk space on {#FSNAME}','vmware.vm.vfs.fs.size[{$URL},{HOST.HOST},{#FSNAME},used]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23585,3,'','',10089,'Guest memory usage','vmware.vm.memory.size.usage.guest[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The amount of guest physical memory that is being used by the VM.',0,'30',0,0,0,''),(23586,3,'','',10089,'Host memory usage','vmware.vm.memory.size.usage.host[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The amount of host physical memory allocated to the VM, accounting for saving from memory sharing with other VMs.',0,'30',0,0,0,''),(23587,3,'','',10089,'Private memory','vmware.vm.memory.size.private[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Amount of memory backed by host memory and not being shared.',0,'30',0,0,0,''),(23588,3,'','',10089,'Shared memory','vmware.vm.memory.size.shared[{$URL},{HOST.HOST}]',60,90,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','The amount of guest physical memory shared through transparent page sharing.',0,'30',0,0,0,''),(23593,3,'','',10088,'Event log','vmware.eventlog[{$URL}]',60,90,365,0,2,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23595,3,'','',10088,'Discover VMware clusters','vmware.cluster.discovery[{$URL}]',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,':',NULL,'','Discovery of clusters',0,'30',0,0,0,''),(23596,3,'','',10088,'Status of \"$2\" cluster','vmware.cluster.status[{$URL},{#CLUSTER.NAME}]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,13,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23597,3,'','',10089,'Cluster name','vmware.vm.cluster.name[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Cluster name of the guest VM.',0,'30',0,0,0,''),(23598,3,'','',10091,'Cluster name','vmware.hv.cluster.name[{$URL},{HOST.HOST}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','Cluster name of the guest VM.',0,'30',0,0,0,''),(23599,3,'','',10089,'Disk device discovery','vmware.vm.vfs.dev.discovery[{$URL},{HOST.HOST}]',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,':',NULL,'','Discovery of all disk devices.',0,'30',0,0,0,''),(23600,3,'','',10089,'Network device discovery','vmware.vm.net.if.discovery[{$URL},{HOST.HOST}]',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,':',NULL,'','Discovery of all network devices.',0,'30',0,0,0,''),(23601,3,'','',10089,'Average number of bytes read from {#DISKDESC}','vmware.vm.vfs.dev.read[{$URL},{HOST.HOST},{#DISKNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23602,3,'','',10089,'Average number of bytes written to {#DISKDESC}','vmware.vm.vfs.dev.write[{$URL},{HOST.HOST},{#DISKNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23603,3,'','',10089,'Average number of reads from {#DISKDESC}','vmware.vm.vfs.dev.read[{$URL},{HOST.HOST},{#DISKNAME},ops]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23604,3,'','',10089,'Average number of writes to {#DISKDESC}','vmware.vm.vfs.dev.write[{$URL},{HOST.HOST},{#DISKNAME},ops]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23605,3,'','',10089,'Number of packets received on {#IFDESC}','vmware.vm.net.if.in[{$URL},{HOST.HOST},{#IFNAME},pps]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23606,3,'','',10089,'Number of packets transmitted on {#IFDESC}','vmware.vm.net.if.out[{$URL},{HOST.HOST},{#IFNAME},pps]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23607,3,'','',10089,'Number of bytes received on {#IFDESC}','vmware.vm.net.if.in[{$URL},{HOST.HOST},{#IFNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23608,3,'','',10089,'Number of bytes transmitted on {#IFDESC}','vmware.vm.net.if.out[{$URL},{HOST.HOST},{#IFNAME},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23620,5,'','',10084,'Zabbix value cache, % free','zabbix[vcache,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',22191,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23625,5,'','',10084,'Zabbix value cache hits','zabbix[vcache,cache,hits]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',22196,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23628,5,'','',10084,'Zabbix value cache misses','zabbix[vcache,cache,misses]',60,7,365,0,0,'','vps',0,1,'',0,'','','1','',0,'',22199,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23629,3,'','',10091,'Number of bytes received','vmware.hv.network.in[{$URL},{HOST.HOST},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23630,3,'','',10091,'Number of bytes transmitted','vmware.hv.network.out[{$URL},{HOST.HOST},bps]',60,90,365,0,3,'','Bps',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23631,3,'','',10091,'Datastore discovery','vmware.hv.datastore.discovery[{$URL},{HOST.HOST}]',3600,90,365,0,4,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,1,':',NULL,'','',0,'30',0,0,0,''),(23632,3,'','',10091,'Average read latency of the datastore $3','vmware.hv.datastore.read[{$URL},{HOST.HOST},{#DATASTORE},latency]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23633,3,'','',10091,'Average write latency of the datastore $3','vmware.hv.datastore.write[{$URL},{HOST.HOST},{#DATASTORE},latency]',60,90,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,2,'',NULL,'','',0,'30',0,0,0,''),(23634,5,'','',10047,'Zabbix vmware cache, % free','zabbix[vmware,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23635,5,'','',10084,'Zabbix vmware cache, % free','zabbix[vmware,buffer,pfree]',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',23634,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23636,16,'','',10082,'jvm Name','jmx[\"java.lang:type=Runtime\",VmName]',3600,7,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23637,16,'','',10082,'os Process CPU Load','jmx[\"java.lang:type=OperatingSystem\",ProcessCpuLoad]',60,7,365,0,0,'','%',1,0,'',0,'','','100','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23638,16,'','',10082,'mem Heap Memory used','jmx[\"java.lang:type=Memory\",HeapMemoryUsage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23639,16,'','',10082,'mem Heap Memory committed','jmx[\"java.lang:type=Memory\",HeapMemoryUsage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23640,16,'','',10082,'mem Heap Memory max','jmx[\"java.lang:type=Memory\",HeapMemoryUsage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23641,16,'','',10082,'mem Non-Heap Memory committed','jmx[\"java.lang:type=Memory\",NonHeapMemoryUsage.committed]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23642,16,'','',10082,'mem Non-Heap Memory used','jmx[\"java.lang:type=Memory\",NonHeapMemoryUsage.used]',60,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23643,16,'','',10082,'mem Non-Heap Memory max','jmx[\"java.lang:type=Memory\",NonHeapMemoryUsage.max]',3600,7,365,0,3,'','B',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23644,3,'','',10093,'FTP service is running','net.tcp.service[ftp]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23645,3,'','',10094,'HTTP service is running','net.tcp.service[http]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23646,3,'','',10095,'HTTPS service is running','net.tcp.service[https]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23647,3,'','',10096,'IMAP service is running','net.tcp.service[imap]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23648,3,'','',10097,'LDAP service is running','net.tcp.service[ldap]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23649,3,'','',10098,'NNTP service is running','net.tcp.service[nntp]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23650,3,'','',10099,'NTP service is running','net.tcp.service[ntp]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23651,3,'','',10100,'POP service is running','net.tcp.service[pop]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23652,3,'','',10101,'SMTP service is running','net.tcp.service[smtp]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23653,3,'','',10102,'SSH service is running','net.tcp.service[ssh]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23654,3,'','',10103,'Telnet service is running','net.tcp.service[telnet]',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'0',0,0,0,''),(23655,3,'','',10104,'ICMP ping','icmpping',60,7,365,0,3,'','',0,0,'',0,'','','1','',0,'',NULL,1,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23656,3,'','',10104,'ICMP response time','icmppingsec',60,7,365,0,0,'','s',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23657,3,'','',10104,'ICMP loss','icmppingloss',60,7,365,0,0,'','%',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'','','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23658,3,'','',10088,'Full name','vmware.fullname[{$URL}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','',0,'30',0,0,0,''),(23659,3,'','',10088,'Version','vmware.version[{$URL}]',3600,90,365,0,1,'','',0,0,'',0,'','','1','',0,'',NULL,NULL,'','','',0,0,'{$USERNAME}','{$PASSWORD}','','',0,0,'',NULL,'','',0,'30',0,0,0,'');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items_applications`
--

DROP TABLE IF EXISTS `items_applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items_applications` (
  `itemappid` bigint(20) unsigned NOT NULL,
  `applicationid` bigint(20) unsigned NOT NULL,
  `itemid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`itemappid`),
  UNIQUE KEY `items_applications_1` (`applicationid`,`itemid`),
  KEY `items_applications_2` (`itemid`),
  CONSTRAINT `c_items_applications_2` FOREIGN KEY (`itemid`) REFERENCES `items` (`itemid`) ON DELETE CASCADE,
  CONSTRAINT `c_items_applications_1` FOREIGN KEY (`applicationid`) REFERENCES `applications` (`applicationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items_applications`
--

LOCK TABLES `items_applications` WRITE;
/*!40000 ALTER TABLE `items_applications` DISABLE KEYS */;
INSERT INTO `items_applications` VALUES (4653,1,10016),(694,1,10025),(636,1,10055),(634,1,10056),(448,1,10057),(444,1,10058),(646,1,17318),(642,1,17352),(4462,5,22452),(4464,5,22454),(4466,5,22456),(4468,5,22458),(4704,5,22686),(4458,7,22446),(4460,7,22448),(600,9,10009),(804,9,10013),(587,13,10010),(689,13,17354),(671,13,17356),(675,13,17358),(679,13,17360),(683,13,17362),(4659,13,22665),(4665,13,22668),(4671,13,22671),(4677,13,22674),(4683,13,22677),(4692,13,22680),(4698,13,22683),(4587,15,10014),(4593,15,10026),(4595,15,10030),(4589,15,17350),(4583,15,22181),(588,17,10010),(690,17,17354),(672,17,17356),(676,17,17358),(680,17,17360),(684,17,17362),(4660,17,22665),(4666,17,22668),(4672,17,22671),(4678,17,22674),(4684,17,22677),(4693,17,22680),(4699,17,22683),(693,21,10025),(447,21,10057),(443,21,10058),(645,21,17318),(641,21,17352),(4654,23,10016),(654,23,10019),(4447,179,22183),(4443,179,22185),(4441,179,22187),(4097,179,22189),(5813,179,22191),(5814,179,22196),(5815,179,22199),(4451,179,22219),(4445,179,22396),(4398,179,22399),(4400,179,22400),(4401,179,22401),(4402,179,22402),(4404,179,22404),(4406,179,22406),(4408,179,22408),(4410,179,22410),(4412,179,22412),(4414,179,22414),(4416,179,22416),(4418,179,22418),(4420,179,22420),(4422,179,22422),(4424,179,22424),(4426,179,22426),(4428,179,22428),(4430,179,22430),(4707,179,22689),(5341,179,23171),(5421,179,23251),(5849,179,23634),(4548,206,22231),(4544,206,22232),(5514,206,23318),(4545,207,10020),(4549,207,10059),(5515,207,23319),(4719,227,22701),(4720,227,22702),(4721,227,22703),(4722,227,22704),(4723,227,22705),(4724,227,22706),(4725,227,22707),(4726,227,22708),(4762,227,22709),(4727,228,22710),(4728,228,22711),(4729,228,22712),(4730,228,22713),(4731,228,22714),(4732,229,22715),(4733,229,22716),(4734,229,22717),(4735,229,22718),(4736,229,22719),(4737,230,22721),(4738,230,22722),(4739,230,22723),(4740,230,22724),(4741,230,22725),(4742,230,22726),(4743,230,22727),(4744,230,22728),(4763,230,22729),(4745,231,22730),(4746,231,22731),(4747,231,22732),(4748,231,22733),(4749,231,22734),(4750,232,22736),(4751,232,22737),(4752,232,22738),(4753,232,22739),(4754,232,22740),(4755,232,22741),(4756,232,22742),(4757,232,22743),(4764,232,22744),(4758,234,22749),(4759,234,22755),(4760,234,22756),(4761,234,22757),(4765,234,22758),(4766,234,22759),(4767,235,22761),(4768,235,22762),(4769,235,22763),(4770,235,22764),(4771,235,22765),(4772,235,22766),(4773,236,22768),(4774,236,22769),(4775,236,22770),(4776,236,22771),(4777,236,22772),(4778,236,22773),(4779,237,22774),(4780,237,22775),(4781,237,22776),(4782,237,22777),(4783,237,22778),(4784,238,22780),(4785,238,22781),(4786,238,22782),(4787,238,22783),(4788,238,22784),(4789,238,22785),(4790,238,22786),(4791,238,22787),(4792,238,22788),(4793,240,22793),(4794,241,22797),(4795,242,22799),(4817,245,22800),(4818,245,22801),(4819,245,22802),(4820,245,22803),(4821,245,22805),(4823,245,22806),(4822,246,22804),(4824,247,22807),(4825,248,22809),(4826,248,22810),(4827,248,22811),(4828,248,22812),(4829,248,22813),(4830,248,22814),(4831,248,22816),(4832,249,22808),(4833,249,22815),(4834,250,22817),(4835,250,22818),(4836,251,22819),(4837,251,22820),(4838,251,22821),(4839,251,22822),(4840,251,22823),(4841,251,22824),(4842,251,22825),(4843,251,22826),(4844,251,22827),(4845,251,22828),(4846,251,22829),(4847,251,22830),(4848,251,22831),(4849,251,22832),(4850,252,22833),(4851,252,22834),(5516,252,23320),(4858,253,22840),(4860,253,22841),(4862,253,22842),(4864,253,22843),(4866,253,22844),(4868,253,22845),(4870,253,22846),(4874,253,22848),(4880,253,22851),(4882,253,22852),(5276,254,22868),(5278,254,22869),(5279,254,22870),(5280,254,22871),(5277,254,22872),(4857,255,22839),(4885,255,22853),(4887,255,22854),(4892,255,22858),(4894,255,22859),(4888,256,22855),(4889,256,22856),(4890,256,22857),(4898,256,22862),(4899,256,22863),(5152,257,23075),(5153,257,23076),(4852,258,22835),(4853,258,22836),(4856,258,22839),(4884,258,22853),(4886,258,22854),(4891,258,22858),(4893,258,22859),(4895,258,22860),(4859,259,22840),(4861,259,22841),(4863,259,22842),(4865,259,22843),(4867,259,22844),(4869,259,22845),(4871,259,22846),(4875,259,22848),(4881,259,22851),(4883,259,22852),(4854,260,22837),(4855,260,22838),(4896,261,22860),(4897,261,22861),(4900,262,22873),(4901,262,22874),(5517,262,23321),(4908,263,22880),(4910,263,22881),(4912,263,22882),(4914,263,22883),(4916,263,22884),(4918,263,22885),(4920,263,22886),(4924,263,22888),(4930,263,22891),(4932,263,22892),(5256,264,22908),(5258,264,22909),(5259,264,22910),(5260,264,22911),(5257,264,22912),(4907,265,22879),(4935,265,22893),(4937,265,22894),(4942,265,22898),(4944,265,22899),(4938,266,22895),(4939,266,22896),(4940,266,22897),(4948,266,22902),(4949,266,22903),(5150,267,23073),(5151,267,23074),(4902,268,22875),(4903,268,22876),(4906,268,22879),(4934,268,22893),(4936,268,22894),(4941,268,22898),(4943,268,22899),(4945,268,22900),(4909,269,22880),(4911,269,22881),(4913,269,22882),(4915,269,22883),(4917,269,22884),(4919,269,22885),(4921,269,22886),(4925,269,22888),(4931,269,22891),(4933,269,22892),(4904,270,22877),(4905,270,22878),(4946,271,22900),(4947,271,22901),(4950,272,22913),(4951,272,22914),(5518,272,23322),(4958,273,22920),(4960,273,22921),(4962,273,22922),(4964,273,22923),(4966,273,22924),(5310,273,23108),(5307,273,23109),(5290,273,23110),(5313,273,23111),(5304,273,23112),(5296,273,23113),(5292,273,23114),(5294,273,23115),(5330,273,23118),(5332,273,23119),(5334,273,23120),(5336,273,23121),(5877,273,23123),(5248,274,22948),(5250,274,22949),(5251,274,22950),(5252,274,22951),(5249,274,22952),(5323,274,23116),(5326,274,23117),(5512,275,22933),(4987,275,22934),(4992,275,22938),(4994,275,22939),(4998,276,22942),(4999,276,22943),(5875,276,23122),(5193,276,23124),(5194,276,23125),(5319,276,23126),(5321,276,23127),(5322,276,23128),(5316,276,23129),(5317,276,23130),(5325,276,23131),(5254,277,22945),(5255,277,22946),(5513,278,22933),(4986,278,22934),(4991,278,22938),(4993,278,22939),(4995,278,22940),(4959,279,22920),(4961,279,22921),(4963,279,22922),(4965,279,22923),(4967,279,22924),(5312,279,23108),(5309,279,23109),(5291,279,23110),(5315,279,23111),(5305,279,23112),(5297,279,23113),(5293,279,23114),(5295,279,23115),(5324,279,23116),(5327,279,23117),(5333,279,23119),(5335,279,23120),(5337,279,23121),(5876,279,23122),(5878,279,23123),(4954,280,22917),(4955,280,22918),(4996,281,22940),(4997,281,22941),(5000,282,22953),(5001,282,22954),(5519,282,23323),(5010,283,22961),(5012,283,22962),(5014,283,22963),(5018,283,22965),(5024,283,22968),(5030,283,22971),(5032,283,22972),(5262,284,22988),(5264,284,22989),(5265,284,22990),(5267,284,22991),(5263,284,22992),(5035,285,22973),(5037,285,22974),(5042,285,22978),(5048,286,22982),(5049,286,22983),(5268,287,22985),(5269,287,22986),(5034,288,22973),(5036,288,22974),(5041,288,22978),(5045,288,22980),(5011,289,22961),(5013,289,22962),(5015,289,22963),(5019,289,22965),(5025,289,22968),(5031,289,22971),(5033,289,22972),(5046,291,22980),(5047,291,22981),(5050,292,22993),(5051,292,22994),(5520,292,23324),(5058,293,23000),(5060,293,23001),(5062,293,23002),(5064,293,23003),(5066,293,23004),(5068,293,23005),(5072,293,23007),(5080,293,23011),(5082,293,23012),(5281,294,23028),(5284,294,23029),(5285,294,23030),(5286,294,23031),(5283,294,23032),(5057,295,22999),(5085,295,23013),(5087,295,23014),(5092,295,23018),(5094,295,23019),(5088,296,23015),(5089,296,23016),(5090,296,23017),(5098,296,23022),(5099,296,23023),(5287,297,23025),(5288,297,23026),(5053,298,22996),(5056,298,22999),(5084,298,23013),(5086,298,23014),(5091,298,23018),(5093,298,23019),(5095,298,23020),(5059,299,23000),(5061,299,23001),(5063,299,23002),(5065,299,23003),(5067,299,23004),(5069,299,23005),(5073,299,23007),(5081,299,23011),(5083,299,23012),(5054,300,22997),(5055,300,22998),(5096,301,23020),(5097,301,23021),(5100,302,23033),(5101,302,23034),(5521,302,23325),(5110,303,23041),(5112,303,23042),(5114,303,23043),(5271,304,23068),(5273,304,23069),(5274,304,23070),(5275,304,23071),(5272,304,23072),(5107,305,23039),(5135,305,23053),(5137,305,23054),(5142,305,23058),(5144,305,23059),(5148,306,23062),(5149,306,23063),(5154,307,23077),(5155,307,23078),(5102,308,23035),(5103,308,23036),(5106,308,23039),(5134,308,23053),(5136,308,23054),(5141,308,23058),(5143,308,23059),(5145,308,23060),(5111,309,23041),(5113,309,23042),(5115,309,23043),(5146,311,23060),(5147,311,23061),(5510,319,23149),(5217,319,23150),(5229,320,23134),(5231,320,23135),(5424,320,23136),(5426,320,23137),(5233,320,23143),(5246,320,23144),(5244,320,23145),(5228,322,23134),(5230,322,23135),(5423,322,23136),(5425,322,23137),(5247,322,23164),(5253,322,23165),(5266,322,23167),(5270,322,23168),(5204,323,23138),(5511,323,23149),(5206,324,23140),(5232,325,23143),(5245,325,23144),(5243,325,23145),(5234,328,23147),(5235,328,23148),(5226,328,23158),(5240,328,23159),(5241,329,23160),(5242,329,23161),(5522,329,23326),(5282,330,23169),(5289,330,23170),(5311,331,23108),(5308,331,23109),(5314,331,23111),(5306,331,23112),(5331,331,23118),(5343,332,23173),(5344,332,23174),(5345,332,23175),(5342,333,23172),(5382,333,23212),(5346,334,23176),(5347,334,23177),(5348,334,23178),(5349,334,23179),(5350,334,23180),(5351,334,23181),(5352,334,23182),(5353,334,23183),(5354,334,23184),(5355,334,23185),(5356,334,23186),(5357,334,23187),(5360,335,23190),(5853,335,23638),(5854,335,23639),(5855,335,23640),(5856,335,23641),(5857,335,23642),(5858,335,23643),(5361,336,23191),(5362,336,23192),(5363,336,23193),(5364,336,23194),(5365,336,23195),(5366,336,23196),(5367,336,23197),(5368,336,23198),(5369,336,23199),(5370,336,23200),(5371,336,23201),(5372,336,23202),(5373,336,23203),(5374,336,23204),(5375,336,23205),(5376,336,23206),(5377,336,23207),(5378,336,23208),(5379,336,23209),(5380,336,23210),(5381,336,23211),(5383,337,23213),(5384,337,23214),(5852,337,23637),(5358,338,23188),(5359,338,23189),(5851,338,23636),(5385,339,23215),(5386,339,23216),(5387,339,23217),(5388,339,23218),(5389,340,23219),(5390,340,23220),(5391,340,23221),(5392,340,23222),(5393,340,23223),(5394,340,23224),(5395,340,23225),(5396,340,23226),(5397,340,23227),(5398,341,23228),(5399,341,23229),(5400,341,23230),(5401,341,23231),(5402,341,23232),(5403,341,23233),(5404,341,23234),(5405,341,23235),(5406,341,23236),(5407,342,23237),(5408,342,23238),(5409,342,23239),(5410,342,23240),(5411,342,23241),(5412,342,23242),(5413,342,23243),(5414,342,23244),(5415,343,23245),(5416,343,23246),(5417,343,23247),(5418,343,23248),(5419,343,23249),(5420,344,23250),(5427,345,23252),(5428,345,23253),(5429,345,23254),(5430,345,23255),(5431,345,23256),(5432,345,23257),(5433,345,23258),(5434,345,23259),(5435,345,23260),(5436,345,23261),(5437,345,23262),(5438,345,23263),(5439,345,23264),(5440,345,23265),(5441,345,23266),(5442,345,23267),(5443,345,23268),(5444,345,23269),(5445,345,23270),(5446,345,23271),(5447,345,23272),(5448,345,23273),(5449,345,23274),(5450,345,23275),(5451,345,23276),(5452,345,23277),(5524,345,23328),(5527,345,23620),(5528,345,23625),(5529,345,23628),(5850,345,23635),(5468,346,23294),(5470,346,23295),(5472,346,23296),(5474,346,23297),(5476,346,23298),(5478,346,23299),(5480,346,23300),(5482,346,23301),(5484,346,23302),(5486,346,23303),(5488,346,23304),(5490,346,23305),(5492,346,23306),(5455,347,23282),(5456,347,23283),(5457,347,23284),(5458,347,23285),(5459,347,23286),(5467,348,23293),(5495,348,23307),(5497,348,23308),(5502,348,23312),(5504,348,23313),(5498,349,23309),(5499,349,23310),(5500,349,23311),(5508,349,23316),(5509,349,23317),(5453,350,23280),(5454,350,23281),(5462,351,23289),(5463,351,23290),(5466,351,23293),(5494,351,23307),(5496,351,23308),(5501,351,23312),(5503,351,23313),(5505,351,23314),(5469,352,23294),(5471,352,23295),(5473,352,23296),(5475,352,23297),(5477,352,23298),(5479,352,23299),(5481,352,23300),(5483,352,23301),(5485,352,23302),(5487,352,23303),(5489,352,23304),(5491,352,23305),(5493,352,23306),(5464,353,23291),(5465,353,23292),(5506,354,23314),(5507,354,23315),(5460,355,23287),(5461,355,23288),(5523,355,23327),(5816,356,23340),(5817,356,23341),(5818,356,23342),(5819,356,23343),(5820,356,23344),(5821,356,23345),(5822,356,23346),(5823,356,23347),(5824,356,23348),(5825,356,23349),(5826,356,23350),(5827,356,23351),(5828,356,23352),(5829,356,23353),(5830,356,23354),(5831,356,23355),(5832,356,23356),(5833,356,23357),(5834,356,23358),(5835,356,23359),(5836,356,23360),(5747,408,23550),(5748,408,23551),(5740,410,23543),(5741,410,23544),(5742,410,23545),(5743,410,23546),(5841,410,23585),(5842,410,23586),(5843,410,23587),(5844,410,23588),(5749,412,23552),(5750,412,23553),(5774,412,23573),(5795,412,23597),(5744,414,23547),(5745,414,23548),(5746,414,23549),(5752,416,23556),(5754,416,23557),(5756,416,23558),(5758,416,23559),(5760,416,23560),(5761,418,23561),(5763,418,23563),(5766,418,23565),(5769,418,23568),(5770,418,23569),(5796,418,23598),(5751,420,23555),(5753,420,23556),(5755,420,23557),(5757,420,23558),(5759,420,23559),(5762,420,23562),(5764,420,23564),(5768,420,23567),(5765,422,23564),(5767,422,23566),(5773,422,23572),(5776,424,23576),(5777,424,23577),(5778,424,23578),(5779,424,23579),(5793,433,23593),(5794,434,23596),(5797,435,23601),(5798,435,23602),(5799,435,23603),(5800,435,23604),(5801,437,23605),(5802,437,23606),(5803,437,23607),(5804,437,23608),(5845,443,23629),(5846,443,23630),(5847,445,23632),(5848,445,23633),(5859,446,23644),(5860,447,23645),(5861,448,23646),(5862,449,23647),(5863,450,23648),(5864,451,23649),(5865,452,23650),(5866,453,23651),(5867,454,23652),(5868,455,23653),(5869,456,23654),(5870,457,23655),(5871,457,23656),(5872,457,23657),(5873,458,23658),(5874,458,23659);
/*!40000 ALTER TABLE `items_applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances`
--

DROP TABLE IF EXISTS `maintenances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances` (
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `maintenance_type` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `active_since` int(11) NOT NULL DEFAULT '0',
  `active_till` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`maintenanceid`),
  KEY `maintenances_1` (`active_since`,`active_till`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances`
--

LOCK TABLES `maintenances` WRITE;
/*!40000 ALTER TABLE `maintenances` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_groups`
--

DROP TABLE IF EXISTS `maintenances_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_groups` (
  `maintenance_groupid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_groupid`),
  UNIQUE KEY `maintenances_groups_1` (`maintenanceid`,`groupid`),
  KEY `maintenances_groups_2` (`groupid`),
  CONSTRAINT `c_maintenances_groups_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_groups_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_groups`
--

LOCK TABLES `maintenances_groups` WRITE;
/*!40000 ALTER TABLE `maintenances_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_hosts`
--

DROP TABLE IF EXISTS `maintenances_hosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_hosts` (
  `maintenance_hostid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_hostid`),
  UNIQUE KEY `maintenances_hosts_1` (`maintenanceid`,`hostid`),
  KEY `maintenances_hosts_2` (`hostid`),
  CONSTRAINT `c_maintenances_hosts_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_hosts_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_hosts`
--

LOCK TABLES `maintenances_hosts` WRITE;
/*!40000 ALTER TABLE `maintenances_hosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_hosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenances_windows`
--

DROP TABLE IF EXISTS `maintenances_windows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintenances_windows` (
  `maintenance_timeperiodid` bigint(20) unsigned NOT NULL,
  `maintenanceid` bigint(20) unsigned NOT NULL,
  `timeperiodid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`maintenance_timeperiodid`),
  UNIQUE KEY `maintenances_windows_1` (`maintenanceid`,`timeperiodid`),
  KEY `maintenances_windows_2` (`timeperiodid`),
  CONSTRAINT `c_maintenances_windows_2` FOREIGN KEY (`timeperiodid`) REFERENCES `timeperiods` (`timeperiodid`) ON DELETE CASCADE,
  CONSTRAINT `c_maintenances_windows_1` FOREIGN KEY (`maintenanceid`) REFERENCES `maintenances` (`maintenanceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenances_windows`
--

LOCK TABLES `maintenances_windows` WRITE;
/*!40000 ALTER TABLE `maintenances_windows` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenances_windows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mappings`
--

DROP TABLE IF EXISTS `mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mappings` (
  `mappingid` bigint(20) unsigned NOT NULL,
  `valuemapid` bigint(20) unsigned NOT NULL,
  `value` varchar(64) NOT NULL DEFAULT '',
  `newvalue` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`mappingid`),
  KEY `mappings_1` (`valuemapid`),
  CONSTRAINT `c_mappings_1` FOREIGN KEY (`valuemapid`) REFERENCES `valuemaps` (`valuemapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mappings`
--

LOCK TABLES `mappings` WRITE;
/*!40000 ALTER TABLE `mappings` DISABLE KEYS */;
INSERT INTO `mappings` VALUES (1,1,'0','Down'),(2,1,'1','Up'),(3,2,'0','Up'),(4,2,'2','Unreachable'),(13,6,'1','Other'),(14,6,'2','OK'),(15,6,'3','Degraded'),(17,7,'1','Other'),(18,7,'2','Unknown'),(19,7,'3','OK'),(20,7,'4','NonCritical'),(21,7,'5','Critical'),(22,7,'6','NonRecoverable'),(23,5,'1','unknown'),(24,5,'2','batteryNormal'),(25,5,'3','batteryLow'),(26,4,'1','unknown'),(27,4,'2','notInstalled'),(28,4,'3','ok'),(29,4,'4','failed'),(30,4,'5','highTemperature'),(31,4,'6','replaceImmediately'),(32,4,'7','lowCapacity'),(33,3,'0','Running'),(34,3,'1','Paused'),(35,3,'3','Pause pending'),(36,3,'4','Continue pending'),(37,3,'5','Stop pending'),(38,3,'6','Stopped'),(39,3,'7','Unknown'),(40,3,'255','No such service'),(41,3,'2','Start pending'),(49,9,'1','unknown'),(50,9,'2','running'),(51,9,'3','warning'),(52,9,'4','testing'),(53,9,'5','down'),(61,8,'1','up'),(62,8,'2','down'),(63,8,'3','testing'),(64,8,'4','unknown'),(65,8,'5','dormant'),(66,8,'6','notPresent'),(67,8,'7','lowerLayerDown'),(68,10,'1','Up'),(69,11,'1','up'),(70,11,'2','down'),(71,11,'3','testing'),(72,12,'0','poweredOff'),(73,12,'1','poweredOn'),(74,12,'2','suspended'),(75,13,'0','gray'),(76,13,'1','green'),(77,13,'2','yellow'),(78,13,'3','red');
/*!40000 ALTER TABLE `mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `mediaid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `sendto` varchar(100) NOT NULL DEFAULT '',
  `active` int(11) NOT NULL DEFAULT '0',
  `severity` int(11) NOT NULL DEFAULT '63',
  `period` varchar(100) NOT NULL DEFAULT '1-7,00:00-24:00',
  PRIMARY KEY (`mediaid`),
  KEY `media_1` (`userid`),
  KEY `media_2` (`mediatypeid`),
  CONSTRAINT `c_media_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`) ON DELETE CASCADE,
  CONSTRAINT `c_media_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_type`
--

DROP TABLE IF EXISTS `media_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_type` (
  `mediatypeid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `description` varchar(100) NOT NULL DEFAULT '',
  `smtp_server` varchar(255) NOT NULL DEFAULT '',
  `smtp_helo` varchar(255) NOT NULL DEFAULT '',
  `smtp_email` varchar(255) NOT NULL DEFAULT '',
  `exec_path` varchar(255) NOT NULL DEFAULT '',
  `gsm_modem` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `passwd` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mediatypeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_type`
--

LOCK TABLES `media_type` WRITE;
/*!40000 ALTER TABLE `media_type` DISABLE KEYS */;
INSERT INTO `media_type` VALUES (1,0,'Email','mail.company.com','company.com','zabbix@company.com','','','','',0),(2,3,'Jabber','','','','','','jabber@company.com','zabbix',0),(3,2,'SMS','','','','','/dev/ttyS0','','',0);
/*!40000 ALTER TABLE `media_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `node_cksum`
--

DROP TABLE IF EXISTS `node_cksum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `node_cksum` (
  `nodeid` int(11) NOT NULL,
  `tablename` varchar(64) NOT NULL DEFAULT '',
  `recordid` bigint(20) unsigned NOT NULL,
  `cksumtype` int(11) NOT NULL DEFAULT '0',
  `cksum` text NOT NULL,
  `sync` char(128) NOT NULL DEFAULT '',
  KEY `node_cksum_1` (`nodeid`,`cksumtype`,`tablename`,`recordid`),
  CONSTRAINT `c_node_cksum_1` FOREIGN KEY (`nodeid`) REFERENCES `nodes` (`nodeid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `node_cksum`
--

LOCK TABLES `node_cksum` WRITE;
/*!40000 ALTER TABLE `node_cksum` DISABLE KEYS */;
/*!40000 ALTER TABLE `node_cksum` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nodes`
--

DROP TABLE IF EXISTS `nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nodes` (
  `nodeid` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '10051',
  `nodetype` int(11) NOT NULL DEFAULT '0',
  `masterid` int(11) DEFAULT NULL,
  PRIMARY KEY (`nodeid`),
  KEY `nodes_1` (`masterid`),
  CONSTRAINT `c_nodes_1` FOREIGN KEY (`masterid`) REFERENCES `nodes` (`nodeid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nodes`
--

LOCK TABLES `nodes` WRITE;
/*!40000 ALTER TABLE `nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `nodes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand`
--

DROP TABLE IF EXISTS `opcommand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand` (
  `operationid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `scriptid` bigint(20) unsigned DEFAULT NULL,
  `execute_on` int(11) NOT NULL DEFAULT '0',
  `port` varchar(64) NOT NULL DEFAULT '',
  `authtype` int(11) NOT NULL DEFAULT '0',
  `username` varchar(64) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `publickey` varchar(64) NOT NULL DEFAULT '',
  `privatekey` varchar(64) NOT NULL DEFAULT '',
  `command` text NOT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opcommand_1` (`scriptid`),
  CONSTRAINT `c_opcommand_2` FOREIGN KEY (`scriptid`) REFERENCES `scripts` (`scriptid`),
  CONSTRAINT `c_opcommand_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand`
--

LOCK TABLES `opcommand` WRITE;
/*!40000 ALTER TABLE `opcommand` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_grp`
--

DROP TABLE IF EXISTS `opcommand_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_grp` (
  `opcommand_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opcommand_grpid`),
  KEY `opcommand_grp_1` (`operationid`),
  KEY `opcommand_grp_2` (`groupid`),
  CONSTRAINT `c_opcommand_grp_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_opcommand_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_grp`
--

LOCK TABLES `opcommand_grp` WRITE;
/*!40000 ALTER TABLE `opcommand_grp` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcommand_hst`
--

DROP TABLE IF EXISTS `opcommand_hst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opcommand_hst` (
  `opcommand_hstid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `hostid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`opcommand_hstid`),
  KEY `opcommand_hst_1` (`operationid`),
  KEY `opcommand_hst_2` (`hostid`),
  CONSTRAINT `c_opcommand_hst_2` FOREIGN KEY (`hostid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_opcommand_hst_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcommand_hst`
--

LOCK TABLES `opcommand_hst` WRITE;
/*!40000 ALTER TABLE `opcommand_hst` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcommand_hst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opconditions`
--

DROP TABLE IF EXISTS `opconditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opconditions` (
  `opconditionid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `conditiontype` int(11) NOT NULL DEFAULT '0',
  `operator` int(11) NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`opconditionid`),
  KEY `opconditions_1` (`operationid`),
  CONSTRAINT `c_opconditions_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opconditions`
--

LOCK TABLES `opconditions` WRITE;
/*!40000 ALTER TABLE `opconditions` DISABLE KEYS */;
/*!40000 ALTER TABLE `opconditions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `operationid` bigint(20) unsigned NOT NULL,
  `actionid` bigint(20) unsigned NOT NULL,
  `operationtype` int(11) NOT NULL DEFAULT '0',
  `esc_period` int(11) NOT NULL DEFAULT '0',
  `esc_step_from` int(11) NOT NULL DEFAULT '1',
  `esc_step_to` int(11) NOT NULL DEFAULT '1',
  `evaltype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`operationid`),
  KEY `operations_1` (`actionid`),
  CONSTRAINT `c_operations_1` FOREIGN KEY (`actionid`) REFERENCES `actions` (`actionid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (1,2,6,0,1,1,0),(2,2,4,0,1,1,0),(3,3,0,0,1,1,0),(4,4,0,0,1,1,0),(5,5,0,0,1,1,0),(6,6,0,0,1,1,0),(7,7,2,0,1,1,0),(8,7,6,0,1,1,0);
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opgroup`
--

DROP TABLE IF EXISTS `opgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opgroup` (
  `opgroupid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opgroupid`),
  UNIQUE KEY `opgroup_1` (`operationid`,`groupid`),
  KEY `opgroup_2` (`groupid`),
  CONSTRAINT `c_opgroup_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_opgroup_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opgroup`
--

LOCK TABLES `opgroup` WRITE;
/*!40000 ALTER TABLE `opgroup` DISABLE KEYS */;
INSERT INTO `opgroup` VALUES (1,2,2);
/*!40000 ALTER TABLE `opgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage`
--

DROP TABLE IF EXISTS `opmessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage` (
  `operationid` bigint(20) unsigned NOT NULL,
  `default_msg` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `message` text NOT NULL,
  `mediatypeid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`operationid`),
  KEY `opmessage_1` (`mediatypeid`),
  CONSTRAINT `c_opmessage_2` FOREIGN KEY (`mediatypeid`) REFERENCES `media_type` (`mediatypeid`),
  CONSTRAINT `c_opmessage_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage`
--

LOCK TABLES `opmessage` WRITE;
/*!40000 ALTER TABLE `opmessage` DISABLE KEYS */;
INSERT INTO `opmessage` VALUES (3,1,'{TRIGGER.STATUS}: {TRIGGER.NAME}','Trigger: {TRIGGER.NAME}\r\nTrigger status: {TRIGGER.STATUS}\r\nTrigger severity: {TRIGGER.SEVERITY}\r\nTrigger URL: {TRIGGER.URL}\r\n\r\nItem values:\r\n\r\n1. {ITEM.NAME1} ({HOST.NAME1}:{ITEM.KEY1}): {ITEM.VALUE1}\r\n2. {ITEM.NAME2} ({HOST.NAME2}:{ITEM.KEY2}): {ITEM.VALUE2}\r\n3. {ITEM.NAME3} ({HOST.NAME3}:{ITEM.KEY3}): {ITEM.VALUE3}',NULL),(4,1,'','',NULL),(5,1,'','',NULL),(6,1,'','',NULL);
/*!40000 ALTER TABLE `opmessage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_grp`
--

DROP TABLE IF EXISTS `opmessage_grp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_grp` (
  `opmessage_grpid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_grpid`),
  UNIQUE KEY `opmessage_grp_1` (`operationid`,`usrgrpid`),
  KEY `opmessage_grp_2` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_2` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`),
  CONSTRAINT `c_opmessage_grp_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_grp`
--

LOCK TABLES `opmessage_grp` WRITE;
/*!40000 ALTER TABLE `opmessage_grp` DISABLE KEYS */;
INSERT INTO `opmessage_grp` VALUES (1,3,7),(2,4,7),(3,5,7),(4,6,7);
/*!40000 ALTER TABLE `opmessage_grp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opmessage_usr`
--

DROP TABLE IF EXISTS `opmessage_usr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opmessage_usr` (
  `opmessage_usrid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`opmessage_usrid`),
  UNIQUE KEY `opmessage_usr_1` (`operationid`,`userid`),
  KEY `opmessage_usr_2` (`userid`),
  CONSTRAINT `c_opmessage_usr_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`),
  CONSTRAINT `c_opmessage_usr_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opmessage_usr`
--

LOCK TABLES `opmessage_usr` WRITE;
/*!40000 ALTER TABLE `opmessage_usr` DISABLE KEYS */;
/*!40000 ALTER TABLE `opmessage_usr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `optemplate`
--

DROP TABLE IF EXISTS `optemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `optemplate` (
  `optemplateid` bigint(20) unsigned NOT NULL,
  `operationid` bigint(20) unsigned NOT NULL,
  `templateid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`optemplateid`),
  UNIQUE KEY `optemplate_1` (`operationid`,`templateid`),
  KEY `optemplate_2` (`templateid`),
  CONSTRAINT `c_optemplate_2` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`),
  CONSTRAINT `c_optemplate_1` FOREIGN KEY (`operationid`) REFERENCES `operations` (`operationid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `optemplate`
--

LOCK TABLES `optemplate` WRITE;
/*!40000 ALTER TABLE `optemplate` DISABLE KEYS */;
INSERT INTO `optemplate` VALUES (1,1,10001),(2,8,10001);
/*!40000 ALTER TABLE `optemplate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `profileid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `idx` varchar(96) NOT NULL DEFAULT '',
  `idx2` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_int` int(11) NOT NULL DEFAULT '0',
  `value_str` varchar(255) NOT NULL DEFAULT '',
  `source` varchar(96) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`profileid`),
  KEY `profiles_1` (`userid`,`idx`,`idx2`),
  KEY `profiles_2` (`userid`,`profileid`),
  CONSTRAINT `c_profiles_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,2,'web.menu.login.last',0,0,0,'index.php','',3),(2,2,'web.paging.lastpage',0,0,0,'index.php','',3),(3,1,'web.menu.view.last',0,0,0,'dashboard.php','',3),(4,1,'web.paging.lastpage',0,0,0,'actionconf.php','',3),(5,1,'web.menu.config.last',0,0,0,'actionconf.php','',3),(6,1,'web.hosts.php.sort',0,0,0,'name','',3),(7,1,'web.hosts.php.sortorder',0,0,0,'ASC','',3),(8,1,'web.config.groupid',0,0,0,'','',1),(9,1,'web.latest.groupid',0,0,0,'','',1),(10,1,'web.paging.page',0,0,1,'','',2),(11,1,'web.actionconf.php.sort',0,0,0,'name','',3),(12,1,'web.actionconf.php.sortorder',0,0,0,'ASC','',3),(13,1,'web.actionconf.eventsource',0,0,2,'','',2);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_autoreg_host`
--

DROP TABLE IF EXISTS `proxy_autoreg_host`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_autoreg_host` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `host` varchar(64) NOT NULL DEFAULT '',
  `listen_ip` varchar(39) NOT NULL DEFAULT '',
  `listen_port` int(11) NOT NULL DEFAULT '0',
  `listen_dns` varchar(64) NOT NULL DEFAULT '',
  `host_metadata` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_autoreg_host_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_autoreg_host`
--

LOCK TABLES `proxy_autoreg_host` WRITE;
/*!40000 ALTER TABLE `proxy_autoreg_host` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_autoreg_host` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_dhistory`
--

DROP TABLE IF EXISTS `proxy_dhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_dhistory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clock` int(11) NOT NULL DEFAULT '0',
  `druleid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ip` varchar(39) NOT NULL DEFAULT '',
  `port` int(11) NOT NULL DEFAULT '0',
  `key_` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `dcheckid` bigint(20) unsigned DEFAULT NULL,
  `dns` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `proxy_dhistory_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_dhistory`
--

LOCK TABLES `proxy_dhistory` WRITE;
/*!40000 ALTER TABLE `proxy_dhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_dhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proxy_history`
--

DROP TABLE IF EXISTS `proxy_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proxy_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `timestamp` int(11) NOT NULL DEFAULT '0',
  `source` varchar(64) NOT NULL DEFAULT '',
  `severity` int(11) NOT NULL DEFAULT '0',
  `value` longtext NOT NULL,
  `logeventid` int(11) NOT NULL DEFAULT '0',
  `ns` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `proxy_history_1` (`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proxy_history`
--

LOCK TABLES `proxy_history` WRITE;
/*!40000 ALTER TABLE `proxy_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `proxy_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regexps`
--

DROP TABLE IF EXISTS `regexps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `regexps` (
  `regexpid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `test_string` text NOT NULL,
  PRIMARY KEY (`regexpid`),
  KEY `regexps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regexps`
--

LOCK TABLES `regexps` WRITE;
/*!40000 ALTER TABLE `regexps` DISABLE KEYS */;
INSERT INTO `regexps` VALUES (1,'File systems for discovery','ext3'),(2,'Network interfaces for discovery','eth0'),(3,'Storage devices for SNMP discovery','/boot');
/*!40000 ALTER TABLE `regexps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rights`
--

DROP TABLE IF EXISTS `rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rights` (
  `rightid` bigint(20) unsigned NOT NULL,
  `groupid` bigint(20) unsigned NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '0',
  `id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`rightid`),
  KEY `rights_1` (`groupid`),
  KEY `rights_2` (`id`),
  CONSTRAINT `c_rights_2` FOREIGN KEY (`id`) REFERENCES `groups` (`groupid`) ON DELETE CASCADE,
  CONSTRAINT `c_rights_1` FOREIGN KEY (`groupid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rights`
--

LOCK TABLES `rights` WRITE;
/*!40000 ALTER TABLE `rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens`
--

DROP TABLE IF EXISTS `screens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens` (
  `screenid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `hsize` int(11) NOT NULL DEFAULT '1',
  `vsize` int(11) NOT NULL DEFAULT '1',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`screenid`),
  KEY `screens_1` (`templateid`),
  CONSTRAINT `c_screens_1` FOREIGN KEY (`templateid`) REFERENCES `hosts` (`hostid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens`
--

LOCK TABLES `screens` WRITE;
/*!40000 ALTER TABLE `screens` DISABLE KEYS */;
INSERT INTO `screens` VALUES (3,'System performance',2,3,10001),(4,'Zabbix server health',2,3,10047),(5,'System performance',2,2,10076),(6,'System performance',2,2,10077),(7,'System performance',2,2,10075),(9,'System performance',2,3,10074),(10,'System performance',2,3,10078),(15,'MySQL performance',2,1,10073),(16,'Zabbix server',2,2,NULL),(17,'Zabbix proxy health',2,2,10048),(18,'System performance',1,2,10079),(19,'System performance',2,2,10081);
/*!40000 ALTER TABLE `screens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screens_items`
--

DROP TABLE IF EXISTS `screens_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `screens_items` (
  `screenitemid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `resourcetype` int(11) NOT NULL DEFAULT '0',
  `resourceid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '320',
  `height` int(11) NOT NULL DEFAULT '200',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `colspan` int(11) NOT NULL DEFAULT '0',
  `rowspan` int(11) NOT NULL DEFAULT '0',
  `elements` int(11) NOT NULL DEFAULT '25',
  `valign` int(11) NOT NULL DEFAULT '0',
  `halign` int(11) NOT NULL DEFAULT '0',
  `style` int(11) NOT NULL DEFAULT '0',
  `url` varchar(255) NOT NULL DEFAULT '',
  `dynamic` int(11) NOT NULL DEFAULT '0',
  `sort_triggers` int(11) NOT NULL DEFAULT '0',
  `application` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`screenitemid`),
  KEY `screens_items_1` (`screenid`),
  CONSTRAINT `c_screens_items_1` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screens_items`
--

LOCK TABLES `screens_items` WRITE;
/*!40000 ALTER TABLE `screens_items` DISABLE KEYS */;
INSERT INTO `screens_items` VALUES (20,3,0,433,500,120,0,0,1,1,0,1,0,0,'',0,0,''),(22,3,0,387,500,148,1,0,1,1,0,1,0,0,'',0,0,''),(24,4,0,392,500,212,0,0,1,1,0,1,0,0,'',0,0,''),(25,4,0,404,500,100,1,0,1,1,0,1,0,0,'',0,0,''),(26,4,0,406,555,114,0,1,1,1,0,1,0,0,'',0,0,''),(27,4,0,410,500,128,1,1,1,1,0,1,0,0,'',0,0,''),(28,5,0,469,500,148,0,0,1,1,0,1,0,0,'',0,0,''),(30,6,0,475,500,114,0,0,1,1,0,1,0,0,'',0,0,''),(31,6,0,474,500,100,1,0,1,1,0,1,0,0,'',0,0,''),(32,7,0,463,500,120,0,0,1,1,0,1,0,0,'',0,0,''),(33,7,0,462,500,106,1,0,1,1,0,1,0,0,'',0,0,''),(36,9,0,457,500,120,0,0,1,1,0,1,0,0,'',0,0,''),(37,9,0,456,500,106,1,0,1,1,0,1,0,0,'',0,0,''),(40,10,0,481,500,114,0,0,1,1,0,1,0,0,'',0,0,''),(41,10,0,480,500,100,1,0,1,1,0,1,0,0,'',0,0,''),(42,15,0,454,500,200,0,0,1,1,0,1,0,0,'',0,0,''),(43,15,0,455,500,270,1,0,1,1,0,1,0,0,'',0,0,''),(44,16,2,1,500,100,0,0,2,0,0,0,0,0,'',0,0,''),(45,16,0,524,400,156,0,1,1,1,0,0,0,0,'',0,0,''),(46,16,0,525,400,100,1,1,1,1,0,0,0,0,'',0,0,''),(47,4,0,527,500,160,0,2,2,1,0,0,0,0,'',0,0,''),(48,17,0,532,500,212,0,0,1,1,0,1,0,0,'',0,0,''),(49,17,0,530,500,100,1,0,1,1,0,1,0,0,'',0,0,''),(50,17,0,531,500,100,0,1,1,1,0,1,0,0,'',0,0,''),(51,17,0,529,500,128,1,1,1,1,0,1,0,0,'',0,0,''),(52,9,0,544,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(53,5,0,471,500,100,1,0,1,1,0,0,0,0,'',0,0,''),(54,5,0,498,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(55,5,0,540,500,100,1,1,1,1,0,0,0,0,'',0,0,''),(56,7,0,541,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(57,7,0,464,500,300,1,1,1,1,0,0,0,0,'',0,0,''),(58,6,0,542,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(59,3,0,533,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(60,3,0,436,500,300,1,1,1,1,0,0,0,0,'',0,0,''),(61,3,1,10009,500,100,0,2,1,1,0,0,0,0,'',0,0,''),(62,3,1,10013,500,100,1,2,1,1,0,0,0,0,'',0,0,''),(63,18,0,487,500,100,0,0,1,1,0,0,0,0,'',0,0,''),(64,18,0,543,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(65,9,0,458,500,300,1,1,1,1,0,0,0,0,'',0,0,''),(66,9,1,22838,500,100,0,2,1,1,0,0,0,0,'',0,0,''),(67,9,1,22837,500,100,1,2,1,1,0,0,0,0,'',0,0,''),(68,10,0,545,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(69,10,0,482,500,300,1,1,1,1,0,0,0,0,'',0,0,''),(70,10,1,22998,500,100,0,2,1,1,0,0,0,0,'',0,0,''),(71,10,1,22997,500,100,1,2,1,1,0,0,0,0,'',0,0,''),(72,19,0,495,500,100,0,0,1,1,0,0,0,0,'',0,0,''),(73,19,0,546,500,100,1,0,1,1,0,0,0,0,'',0,0,''),(74,19,1,23140,500,100,0,1,1,1,0,0,0,0,'',0,0,''),(75,19,1,23138,500,100,1,1,1,1,0,0,0,0,'',0,0,'');
/*!40000 ALTER TABLE `screens_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scripts`
--

DROP TABLE IF EXISTS `scripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scripts` (
  `scriptid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `command` varchar(255) NOT NULL DEFAULT '',
  `host_access` int(11) NOT NULL DEFAULT '2',
  `usrgrpid` bigint(20) unsigned DEFAULT NULL,
  `groupid` bigint(20) unsigned DEFAULT NULL,
  `description` text NOT NULL,
  `confirmation` varchar(255) NOT NULL DEFAULT '',
  `type` int(11) NOT NULL DEFAULT '0',
  `execute_on` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`scriptid`),
  KEY `scripts_1` (`usrgrpid`),
  KEY `scripts_2` (`groupid`),
  CONSTRAINT `c_scripts_2` FOREIGN KEY (`groupid`) REFERENCES `groups` (`groupid`),
  CONSTRAINT `c_scripts_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scripts`
--

LOCK TABLES `scripts` WRITE;
/*!40000 ALTER TABLE `scripts` DISABLE KEYS */;
INSERT INTO `scripts` VALUES (1,'Ping','/bin/ping -c 3 {HOST.CONN} 2>&1',2,NULL,NULL,'','',0,1),(2,'Traceroute','/usr/bin/traceroute {HOST.CONN} 2>&1',2,NULL,NULL,'','',0,1),(3,'Detect operating system','sudo /usr/bin/nmap -O {HOST.CONN} 2>&1',2,7,NULL,'','',0,1);
/*!40000 ALTER TABLE `scripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_alarms`
--

DROP TABLE IF EXISTS `service_alarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_alarms` (
  `servicealarmid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`servicealarmid`),
  KEY `service_alarms_1` (`serviceid`,`clock`),
  KEY `service_alarms_2` (`clock`),
  CONSTRAINT `c_service_alarms_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_alarms`
--

LOCK TABLES `service_alarms` WRITE;
/*!40000 ALTER TABLE `service_alarms` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_alarms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services` (
  `serviceid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `algorithm` int(11) NOT NULL DEFAULT '0',
  `triggerid` bigint(20) unsigned DEFAULT NULL,
  `showsla` int(11) NOT NULL DEFAULT '0',
  `goodsla` double(16,4) NOT NULL DEFAULT '99.9000',
  `sortorder` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`serviceid`),
  KEY `services_1` (`triggerid`),
  CONSTRAINT `c_services_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_links`
--

DROP TABLE IF EXISTS `services_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `serviceupid` bigint(20) unsigned NOT NULL,
  `servicedownid` bigint(20) unsigned NOT NULL,
  `soft` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`linkid`),
  UNIQUE KEY `services_links_2` (`serviceupid`,`servicedownid`),
  KEY `services_links_1` (`servicedownid`),
  CONSTRAINT `c_services_links_2` FOREIGN KEY (`servicedownid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE,
  CONSTRAINT `c_services_links_1` FOREIGN KEY (`serviceupid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_links`
--

LOCK TABLES `services_links` WRITE;
/*!40000 ALTER TABLE `services_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services_times`
--

DROP TABLE IF EXISTS `services_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `services_times` (
  `timeid` bigint(20) unsigned NOT NULL,
  `serviceid` bigint(20) unsigned NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `ts_from` int(11) NOT NULL DEFAULT '0',
  `ts_to` int(11) NOT NULL DEFAULT '0',
  `note` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`timeid`),
  KEY `services_times_1` (`serviceid`,`type`,`ts_from`,`ts_to`),
  CONSTRAINT `c_services_times_1` FOREIGN KEY (`serviceid`) REFERENCES `services` (`serviceid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services_times`
--

LOCK TABLES `services_times` WRITE;
/*!40000 ALTER TABLE `services_times` DISABLE KEYS */;
/*!40000 ALTER TABLE `services_times` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sessionid` varchar(32) NOT NULL DEFAULT '',
  `userid` bigint(20) unsigned NOT NULL,
  `lastaccess` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sessionid`),
  KEY `sessions_1` (`userid`,`status`),
  CONSTRAINT `c_sessions_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('68eceac7f3d42238c756224a975998cf',1,1450349723,0);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slides`
--

DROP TABLE IF EXISTS `slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slides` (
  `slideid` bigint(20) unsigned NOT NULL,
  `slideshowid` bigint(20) unsigned NOT NULL,
  `screenid` bigint(20) unsigned NOT NULL,
  `step` int(11) NOT NULL DEFAULT '0',
  `delay` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideid`),
  KEY `slides_1` (`slideshowid`),
  KEY `slides_2` (`screenid`),
  CONSTRAINT `c_slides_2` FOREIGN KEY (`screenid`) REFERENCES `screens` (`screenid`) ON DELETE CASCADE,
  CONSTRAINT `c_slides_1` FOREIGN KEY (`slideshowid`) REFERENCES `slideshows` (`slideshowid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slides`
--

LOCK TABLES `slides` WRITE;
/*!40000 ALTER TABLE `slides` DISABLE KEYS */;
/*!40000 ALTER TABLE `slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slideshows`
--

DROP TABLE IF EXISTS `slideshows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slideshows` (
  `slideshowid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `delay` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`slideshowid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slideshows`
--

LOCK TABLES `slideshows` WRITE;
/*!40000 ALTER TABLE `slideshows` DISABLE KEYS */;
/*!40000 ALTER TABLE `slideshows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_element_url`
--

DROP TABLE IF EXISTS `sysmap_element_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_element_url` (
  `sysmapelementurlid` bigint(20) unsigned NOT NULL,
  `selementid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`sysmapelementurlid`),
  UNIQUE KEY `sysmap_element_url_1` (`selementid`,`name`),
  CONSTRAINT `c_sysmap_element_url_1` FOREIGN KEY (`selementid`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_element_url`
--

LOCK TABLES `sysmap_element_url` WRITE;
/*!40000 ALTER TABLE `sysmap_element_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_element_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmap_url`
--

DROP TABLE IF EXISTS `sysmap_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmap_url` (
  `sysmapurlid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL DEFAULT '',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapurlid`),
  UNIQUE KEY `sysmap_url_1` (`sysmapid`,`name`),
  CONSTRAINT `c_sysmap_url_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmap_url`
--

LOCK TABLES `sysmap_url` WRITE;
/*!40000 ALTER TABLE `sysmap_url` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmap_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps`
--

DROP TABLE IF EXISTS `sysmaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps` (
  `sysmapid` bigint(20) unsigned NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT '',
  `width` int(11) NOT NULL DEFAULT '600',
  `height` int(11) NOT NULL DEFAULT '400',
  `backgroundid` bigint(20) unsigned DEFAULT NULL,
  `label_type` int(11) NOT NULL DEFAULT '2',
  `label_location` int(11) NOT NULL DEFAULT '0',
  `highlight` int(11) NOT NULL DEFAULT '1',
  `expandproblem` int(11) NOT NULL DEFAULT '1',
  `markelements` int(11) NOT NULL DEFAULT '0',
  `show_unack` int(11) NOT NULL DEFAULT '0',
  `grid_size` int(11) NOT NULL DEFAULT '50',
  `grid_show` int(11) NOT NULL DEFAULT '1',
  `grid_align` int(11) NOT NULL DEFAULT '1',
  `label_format` int(11) NOT NULL DEFAULT '0',
  `label_type_host` int(11) NOT NULL DEFAULT '2',
  `label_type_hostgroup` int(11) NOT NULL DEFAULT '2',
  `label_type_trigger` int(11) NOT NULL DEFAULT '2',
  `label_type_map` int(11) NOT NULL DEFAULT '2',
  `label_type_image` int(11) NOT NULL DEFAULT '2',
  `label_string_host` varchar(255) NOT NULL DEFAULT '',
  `label_string_hostgroup` varchar(255) NOT NULL DEFAULT '',
  `label_string_trigger` varchar(255) NOT NULL DEFAULT '',
  `label_string_map` varchar(255) NOT NULL DEFAULT '',
  `label_string_image` varchar(255) NOT NULL DEFAULT '',
  `iconmapid` bigint(20) unsigned DEFAULT NULL,
  `expand_macros` int(11) NOT NULL DEFAULT '0',
  `severity_min` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sysmapid`),
  KEY `sysmaps_1` (`name`),
  KEY `sysmaps_2` (`backgroundid`),
  KEY `sysmaps_3` (`iconmapid`),
  CONSTRAINT `c_sysmaps_2` FOREIGN KEY (`iconmapid`) REFERENCES `icon_map` (`iconmapid`),
  CONSTRAINT `c_sysmaps_1` FOREIGN KEY (`backgroundid`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps`
--

LOCK TABLES `sysmaps` WRITE;
/*!40000 ALTER TABLE `sysmaps` DISABLE KEYS */;
INSERT INTO `sysmaps` VALUES (1,'Local network',680,200,NULL,0,0,1,1,1,0,50,1,1,0,2,2,2,2,2,'','','','','',NULL,1,0);
/*!40000 ALTER TABLE `sysmaps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_elements`
--

DROP TABLE IF EXISTS `sysmaps_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_elements` (
  `selementid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `elementid` bigint(20) unsigned NOT NULL DEFAULT '0',
  `elementtype` int(11) NOT NULL DEFAULT '0',
  `iconid_off` bigint(20) unsigned DEFAULT NULL,
  `iconid_on` bigint(20) unsigned DEFAULT NULL,
  `label` varchar(2048) NOT NULL DEFAULT '',
  `label_location` int(11) NOT NULL DEFAULT '-1',
  `x` int(11) NOT NULL DEFAULT '0',
  `y` int(11) NOT NULL DEFAULT '0',
  `iconid_disabled` bigint(20) unsigned DEFAULT NULL,
  `iconid_maintenance` bigint(20) unsigned DEFAULT NULL,
  `elementsubtype` int(11) NOT NULL DEFAULT '0',
  `areatype` int(11) NOT NULL DEFAULT '0',
  `width` int(11) NOT NULL DEFAULT '200',
  `height` int(11) NOT NULL DEFAULT '200',
  `viewtype` int(11) NOT NULL DEFAULT '0',
  `use_iconmap` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`selementid`),
  KEY `sysmaps_elements_1` (`sysmapid`),
  KEY `sysmaps_elements_2` (`iconid_off`),
  KEY `sysmaps_elements_3` (`iconid_on`),
  KEY `sysmaps_elements_4` (`iconid_disabled`),
  KEY `sysmaps_elements_5` (`iconid_maintenance`),
  CONSTRAINT `c_sysmaps_elements_5` FOREIGN KEY (`iconid_maintenance`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_elements_2` FOREIGN KEY (`iconid_off`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_3` FOREIGN KEY (`iconid_on`) REFERENCES `images` (`imageid`),
  CONSTRAINT `c_sysmaps_elements_4` FOREIGN KEY (`iconid_disabled`) REFERENCES `images` (`imageid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_elements`
--

LOCK TABLES `sysmaps_elements` WRITE;
/*!40000 ALTER TABLE `sysmaps_elements` DISABLE KEYS */;
INSERT INTO `sysmaps_elements` VALUES (1,1,10084,0,185,NULL,'{HOST.NAME}\r\n{HOST.CONN}',0,111,61,NULL,NULL,0,0,200,200,0,0);
/*!40000 ALTER TABLE `sysmaps_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_link_triggers`
--

DROP TABLE IF EXISTS `sysmaps_link_triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_link_triggers` (
  `linktriggerid` bigint(20) unsigned NOT NULL,
  `linkid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  PRIMARY KEY (`linktriggerid`),
  UNIQUE KEY `sysmaps_link_triggers_1` (`linkid`,`triggerid`),
  KEY `sysmaps_link_triggers_2` (`triggerid`),
  CONSTRAINT `c_sysmaps_link_triggers_2` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_link_triggers_1` FOREIGN KEY (`linkid`) REFERENCES `sysmaps_links` (`linkid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_link_triggers`
--

LOCK TABLES `sysmaps_link_triggers` WRITE;
/*!40000 ALTER TABLE `sysmaps_link_triggers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_link_triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sysmaps_links`
--

DROP TABLE IF EXISTS `sysmaps_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sysmaps_links` (
  `linkid` bigint(20) unsigned NOT NULL,
  `sysmapid` bigint(20) unsigned NOT NULL,
  `selementid1` bigint(20) unsigned NOT NULL,
  `selementid2` bigint(20) unsigned NOT NULL,
  `drawtype` int(11) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '000000',
  `label` varchar(2048) NOT NULL DEFAULT '',
  PRIMARY KEY (`linkid`),
  KEY `sysmaps_links_1` (`sysmapid`),
  KEY `sysmaps_links_2` (`selementid1`),
  KEY `sysmaps_links_3` (`selementid2`),
  CONSTRAINT `c_sysmaps_links_3` FOREIGN KEY (`selementid2`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_1` FOREIGN KEY (`sysmapid`) REFERENCES `sysmaps` (`sysmapid`) ON DELETE CASCADE,
  CONSTRAINT `c_sysmaps_links_2` FOREIGN KEY (`selementid1`) REFERENCES `sysmaps_elements` (`selementid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sysmaps_links`
--

LOCK TABLES `sysmaps_links` WRITE;
/*!40000 ALTER TABLE `sysmaps_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `sysmaps_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timeperiods`
--

DROP TABLE IF EXISTS `timeperiods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `timeperiods` (
  `timeperiodid` bigint(20) unsigned NOT NULL,
  `timeperiod_type` int(11) NOT NULL DEFAULT '0',
  `every` int(11) NOT NULL DEFAULT '0',
  `month` int(11) NOT NULL DEFAULT '0',
  `dayofweek` int(11) NOT NULL DEFAULT '0',
  `day` int(11) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `period` int(11) NOT NULL DEFAULT '0',
  `start_date` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`timeperiodid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timeperiods`
--

LOCK TABLES `timeperiods` WRITE;
/*!40000 ALTER TABLE `timeperiods` DISABLE KEYS */;
/*!40000 ALTER TABLE `timeperiods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends`
--

DROP TABLE IF EXISTS `trends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_avg` double(16,4) NOT NULL DEFAULT '0.0000',
  `value_max` double(16,4) NOT NULL DEFAULT '0.0000',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends`
--

LOCK TABLES `trends` WRITE;
/*!40000 ALTER TABLE `trends` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trends_uint`
--

DROP TABLE IF EXISTS `trends_uint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trends_uint` (
  `itemid` bigint(20) unsigned NOT NULL,
  `clock` int(11) NOT NULL DEFAULT '0',
  `num` int(11) NOT NULL DEFAULT '0',
  `value_min` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_avg` bigint(20) unsigned NOT NULL DEFAULT '0',
  `value_max` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`itemid`,`clock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trends_uint`
--

LOCK TABLES `trends_uint` WRITE;
/*!40000 ALTER TABLE `trends_uint` DISABLE KEYS */;
/*!40000 ALTER TABLE `trends_uint` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_depends`
--

DROP TABLE IF EXISTS `trigger_depends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_depends` (
  `triggerdepid` bigint(20) unsigned NOT NULL,
  `triggerid_down` bigint(20) unsigned NOT NULL,
  `triggerid_up` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`triggerdepid`),
  UNIQUE KEY `trigger_depends_1` (`triggerid_down`,`triggerid_up`),
  KEY `trigger_depends_2` (`triggerid_up`),
  CONSTRAINT `c_trigger_depends_2` FOREIGN KEY (`triggerid_up`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_depends_1` FOREIGN KEY (`triggerid_down`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_depends`
--

LOCK TABLES `trigger_depends` WRITE;
/*!40000 ALTER TABLE `trigger_depends` DISABLE KEYS */;
INSERT INTO `trigger_depends` VALUES (1,13295,13321),(3,13296,13295),(2,13296,13321),(4,13297,13321),(5,13298,13297),(6,13298,13321),(7,13299,13321),(9,13300,13299),(8,13300,13321),(10,13301,13321),(12,13302,13301),(11,13302,13321),(13,13303,13322),(14,13304,13303),(15,13304,13322),(16,13305,13322),(17,13306,13321),(18,13307,13305),(19,13307,13322),(20,13308,13306),(21,13308,13321),(22,13311,13309),(23,13312,13310),(24,13313,13321),(25,13314,13322),(26,13315,13313),(27,13315,13321),(28,13316,13314),(29,13316,13322),(30,13318,13317),(31,13319,13321),(32,13320,13319),(33,13320,13321),(34,13323,13321),(35,13324,13321),(36,13324,13323),(37,13325,13321),(38,13326,13321),(39,13326,13325),(41,13555,13554),(40,13556,13554);
/*!40000 ALTER TABLE `trigger_depends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_discovery`
--

DROP TABLE IF EXISTS `trigger_discovery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trigger_discovery` (
  `triggerdiscoveryid` bigint(20) unsigned NOT NULL,
  `triggerid` bigint(20) unsigned NOT NULL,
  `parent_triggerid` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`triggerdiscoveryid`),
  UNIQUE KEY `trigger_discovery_1` (`triggerid`,`parent_triggerid`),
  KEY `trigger_discovery_2` (`parent_triggerid`),
  CONSTRAINT `c_trigger_discovery_2` FOREIGN KEY (`parent_triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE,
  CONSTRAINT `c_trigger_discovery_1` FOREIGN KEY (`triggerid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_discovery`
--

LOCK TABLES `trigger_discovery` WRITE;
/*!40000 ALTER TABLE `trigger_discovery` DISABLE KEYS */;
/*!40000 ALTER TABLE `trigger_discovery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `triggers`
--

DROP TABLE IF EXISTS `triggers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `triggers` (
  `triggerid` bigint(20) unsigned NOT NULL,
  `expression` varchar(2048) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) NOT NULL DEFAULT '0',
  `lastchange` int(11) NOT NULL DEFAULT '0',
  `comments` text NOT NULL,
  `error` varchar(128) NOT NULL DEFAULT '',
  `templateid` bigint(20) unsigned DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`triggerid`),
  KEY `triggers_1` (`status`),
  KEY `triggers_2` (`value`),
  KEY `triggers_3` (`templateid`),
  CONSTRAINT `c_triggers_1` FOREIGN KEY (`templateid`) REFERENCES `triggers` (`triggerid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `triggers`
--

LOCK TABLES `triggers` WRITE;
/*!40000 ALTER TABLE `triggers` DISABLE KEYS */;
INSERT INTO `triggers` VALUES (10010,'{13078}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(10011,'{13084}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(10012,'{12580}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(10016,'{10199}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(10021,'{12583}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(10041,'{10204}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10042,'{12553}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10043,'{10208}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10044,'{10207}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(10045,'{12927}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(10047,'{12550}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(10190,'{13082}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13000,'{12144}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13015,'{12641}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0),(13017,'{12651}<25','Less than 25% free in the text history cache','',0,0,3,0,'','',NULL,0,0,0),(13019,'{12649}<25','Less than 25% free in the trends cache','',0,0,3,0,'','',NULL,0,0,0),(13023,'{12653}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0),(13025,'{12549}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',NULL,0,0,0),(13026,'{12926}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13073,'{12645}<25','Less than 25% free in the history cache','',0,0,3,0,'','',NULL,0,0,0),(13074,'{12646}<5','Less than 5% free in the value cache','',0,0,3,0,'','',NULL,0,0,0),(13075,'{12648}<5','Less than 5% free in the value cache','',0,0,3,0,'','',13074,0,0,0),(13080,'({TRIGGER.VALUE}=0&{13099}>75)|({TRIGGER.VALUE}=1&{13099}>65)','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13081,'({TRIGGER.VALUE}=0&{13101}>75)|({TRIGGER.VALUE}=1&{13101}>65)','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13082,'({TRIGGER.VALUE}=0&{13103}>75)|({TRIGGER.VALUE}=1&{13103}>65)','Zabbix db watchdog processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13083,'({TRIGGER.VALUE}=0&{13105}>75)|({TRIGGER.VALUE}=1&{13105}>65)','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13084,'({TRIGGER.VALUE}=0&{13107}>75)|({TRIGGER.VALUE}=1&{13107}>65)','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13085,'({TRIGGER.VALUE}=0&{13109}>75)|({TRIGGER.VALUE}=1&{13109}>65)','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13086,'({TRIGGER.VALUE}=0&{13111}>75)|({TRIGGER.VALUE}=1&{13111}>65)','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13087,'({TRIGGER.VALUE}=0&{13113}>75)|({TRIGGER.VALUE}=1&{13113}>65)','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13088,'({TRIGGER.VALUE}=0&{13115}>75)|({TRIGGER.VALUE}=1&{13115}>65)','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13089,'({TRIGGER.VALUE}=0&{13117}>75)|({TRIGGER.VALUE}=1&{13117}>65)','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13090,'({TRIGGER.VALUE}=0&{13121}>75)|({TRIGGER.VALUE}=1&{13121}>65)','Zabbix node watcher processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13091,'({TRIGGER.VALUE}=0&{13123}>75)|({TRIGGER.VALUE}=1&{13123}>65)','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13092,'({TRIGGER.VALUE}=0&{13125}>75)|({TRIGGER.VALUE}=1&{13125}>65)','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13093,'({TRIGGER.VALUE}=0&{13029}>75)|({TRIGGER.VALUE}=1&{13029}>65)','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13094,'({TRIGGER.VALUE}=0&{13129}>75)|({TRIGGER.VALUE}=1&{13129}>65)','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13095,'({TRIGGER.VALUE}=0&{13131}>75)|({TRIGGER.VALUE}=1&{13131}>65)','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13096,'({TRIGGER.VALUE}=0&{13133}>75)|({TRIGGER.VALUE}=1&{13133}>65)','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13097,'({TRIGGER.VALUE}=0&{13135}>75)|({TRIGGER.VALUE}=1&{13135}>65)','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13243,'{13080}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0),(13266,'{12592}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13272,'{12598}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13275,'({TRIGGER.VALUE}=0&{13119}>75)|({TRIGGER.VALUE}=1&{13119}>65)','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13285,'{13159}=0','Telnet service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13287,'{12671}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',NULL,0,0,2),(13288,'{12672}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',13287,0,0,2),(13289,'{12673}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',13287,0,0,2),(13291,'{12675} / {12676} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',NULL,0,0,2),(13292,'{12677} / {12678} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',13291,0,0,2),(13293,'{12679} / {12680} > 0.8','Free disk space is less than 20% on volume {#SNMPVALUE}','',0,0,2,0,'','',13291,0,0,2),(13294,'{12681}=1','Operational status was changed on {HOST.NAME} interface {#SNMPVALUE}','',0,0,1,0,'','',13287,0,0,2),(13295,'{12682}<5 | {12682}>90','Baseboard Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13296,'{12683}<10 | {12683}>83','Baseboard Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13297,'{12684}<0.953 | {12684}>1.149','BB +1.05V PCH Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13298,'{12685}<0.985 | {12685}>1.117','BB +1.05V PCH Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13299,'{12686}<0.683 | {12686}>1.543','BB +1.1V P1 Vccp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13300,'{12687}<0.708 | {12687}>1.501','BB +1.1V P1 Vccp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13301,'{12688}<1.362 | {12688}>1.635','BB +1.5V P1 DDR3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13302,'{12689}<1.401 | {12689}>1.589','BB +1.5V P1 DDR3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13303,'{12690}<1.597 | {12690}>2.019','BB +1.8V SM Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13304,'{12691}<1.646 | {12691}>1.960','BB +1.8V SM Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13305,'{12692}<2.876 | {12692}>3.729','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13306,'{12693}<2.982 | {12693}>3.625','BB +3.3V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13307,'{12694}<2.970 | {12694}>3.618','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13308,'{12695}<3.067 | {12695}>3.525','BB +3.3V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13309,'{12696}<2.876 | {12696}>3.729','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13310,'{12697}<2.982 | {12697}>3.625','BB +3.3V STBY Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13311,'{12698}<2.970 | {12698}>3.618','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13312,'{12699}<3.067 | {12699}>3.525','BB +3.3V STBY Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13313,'{12700}<4.471 | {12700}>5.538','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13314,'{12701}<4.362 | {12701}>5.663','BB +5.0V Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13315,'{12702}<4.630 | {12702}>5.380','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13316,'{12703}<4.483 | {12703}>5.495','BB +5.0V Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13317,'{12704}<5 | {12704}>66','BB Ambient Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13318,'{12705}<10 | {12705}>61','BB Ambient Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13319,'{12706}<0 | {12706}>48','Front Panel Temp Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13320,'{12707}<5 | {12707}>44','Front Panel Temp Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13321,'{12708}=0','Power','',0,0,2,0,'','',NULL,0,0,0),(13322,'{12709}=0','Power','',0,0,2,0,'','',NULL,0,0,0),(13323,'{12710}<324','System Fan 2 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13324,'{12711}<378','System Fan 2 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13325,'{12712}<324','System Fan 3 Critical [{ITEM.VALUE}]','',0,0,5,0,'','',NULL,0,0,0),(13326,'{12713}<378','System Fan 3 Non-Critical [{ITEM.VALUE}]','',0,0,4,0,'','',NULL,0,0,0),(13327,'{13155}=0','MySQL is down','',0,0,2,0,'','',NULL,0,0,0),(13328,'{12715}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13329,'{12929}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13330,'{12717}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13331,'{12718}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13332,'{13089}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13333,'{13088}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13334,'{13087}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13336,'{12723}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13337,'{12724}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(13338,'{12725}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13339,'{12726}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13340,'{12727}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13341,'{12728}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13342,'{12729}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13343,'{12730}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13344,'{12731}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13345,'{12930}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13346,'{12733}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13347,'{12734}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13348,'{13074}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13349,'{13073}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13350,'{13072}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13352,'{12739}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13353,'{12740}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(13354,'{12741}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13355,'{12742}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13356,'{12743}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13357,'{12744}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13358,'{12745}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13359,'{12746}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13360,'{12747}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13361,'{12931}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13364,'{13071}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13365,'{13070}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13366,'{13069}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13367,'{13068}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0),(13368,'{12755}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13370,'{12757}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13371,'{12758}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13372,'{12759}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13373,'{12760}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13374,'{12761}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13375,'{12762}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13376,'{12763}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13377,'{12932}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13382,'{13075}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13384,'{12771}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13386,'{12773}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13388,'{12775}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13389,'{12776}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13390,'{12777}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13391,'{12778}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13392,'{12779}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13393,'{12933}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13395,'{12782}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13396,'{13093}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13397,'{13092}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13398,'{13091}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13399,'{13090}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',NULL,0,0,0),(13400,'{12787}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13401,'{12788}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',NULL,0,0,0),(13402,'{12789}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13403,'{12790}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13404,'{12791}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13405,'{12792}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13406,'{12793}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13407,'{12794}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13408,'{12795}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13409,'{12934}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13410,'{12797}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13411,'{12798}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13414,'{13086}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13416,'{12803}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13418,'{12805}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13419,'{12806}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',NULL,0,0,0),(13420,'{12807}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13421,'{12808}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13422,'{12809}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13423,'{12810}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13425,'{12812}>0','Host information was changed on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13428,'{12815}<0','{HOST.NAME} has just been restarted','',0,0,3,0,'','',NULL,0,0,0),(13430,'{13095}>300','Too many processes on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13431,'{12818}<100000','Lack of free swap space on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13433,'{12820}<10000','Lack of free memory on server {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13435,'{13094}>5','Processor load is too high on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13436,'({TRIGGER.VALUE}=0&{13136}>75)|({TRIGGER.VALUE}=1&{13136}>65)','Zabbix vmware collector processes more than 75% busy','',0,0,3,0,'','',13097,0,0,0),(13437,'{12824}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',13025,0,0,0),(13438,'{12935}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',13026,0,0,0),(13439,'{12826}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',NULL,0,0,2),(13441,'({TRIGGER.VALUE}=0&{13127}>75)|({TRIGGER.VALUE}=1&{13127}>65)','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13442,'{12830} > ({12831} * 0.7)','70% http-8080 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13443,'{12832} > ({12833} * 0.7)','70% http-8443 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13444,'{12834} > ({12835}  *0.7)','70% jk-8009 worker threads busy on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13445,'{12836}>({12837}*0.7)','70% mp CMS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13446,'{12838}>({12839}*0.7)','70% mp CMS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13447,'{12840}>({12841}*0.7)','70% mp Code Cache used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13448,'{12842}>({12843}*0.7)','70% mp Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13449,'{12844}>({12845}*0.7)','70% mp PS Old Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13450,'{12846}>({12847}*0.7)','70% mp PS Perm Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13451,'{12848}>({12849}*0.7)','70% mp Tenured Gen used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13452,'{12850}>({12851}*0.7)','70% os Opened File Descriptor Count used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13453,'{12852}<{12853}','gc Concurrent Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13454,'{12854}<{12855}','gc Mark Sweep Compact in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13455,'{12856}<{12857}','gc PS Mark Sweep in fire fighting mode on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13456,'{12858} = 1','gzip compression is off for connector http-8080 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13457,'{12859} = 1','gzip compression is off for connector http-8443 on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13458,'{12860}={12861}','mp CMS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13459,'{12862}={12863}','mp CMS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13460,'{12864}={12865}','mp Code Cache fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13461,'{12866}={12867}','mp Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13462,'{12868}={12869}','mp PS Old Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13463,'{12870}={12871}','mp PS Perm Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13464,'{12872}={12873}','mp Tenured Gen fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13465,'{12874}=1','{HOST.NAME} is not reachable','',0,0,3,0,'','',NULL,0,0,0),(13466,'{12967}=1','{HOST.NAME} uses suboptimal JIT compiler','',0,0,1,0,'','',NULL,0,0,0),(13467,'({TRIGGER.VALUE}=0&{13100}>75)|({TRIGGER.VALUE}=1&{13100}>65)','Zabbix alerter processes more than 75% busy','',0,0,3,0,'','',13080,0,0,0),(13468,'({TRIGGER.VALUE}=0&{13102}>75)|({TRIGGER.VALUE}=1&{13102}>65)','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',13081,0,0,0),(13469,'({TRIGGER.VALUE}=0&{13104}>75)|({TRIGGER.VALUE}=1&{13104}>65)','Zabbix db watchdog processes more than 75% busy','',0,0,3,0,'','',13082,0,0,0),(13470,'({TRIGGER.VALUE}=0&{13106}>75)|({TRIGGER.VALUE}=1&{13106}>65)','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',13083,0,0,0),(13471,'({TRIGGER.VALUE}=0&{13108}>75)|({TRIGGER.VALUE}=1&{13108}>65)','Zabbix escalator processes more than 75% busy','',0,0,3,0,'','',13084,0,0,0),(13472,'({TRIGGER.VALUE}=0&{13110}>75)|({TRIGGER.VALUE}=1&{13110}>65)','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',13085,0,0,0),(13473,'({TRIGGER.VALUE}=0&{13112}>75)|({TRIGGER.VALUE}=1&{13112}>65)','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',13086,0,0,0),(13474,'({TRIGGER.VALUE}=0&{13114}>75)|({TRIGGER.VALUE}=1&{13114}>65)','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',13087,0,0,0),(13475,'({TRIGGER.VALUE}=0&{13116}>75)|({TRIGGER.VALUE}=1&{13116}>65)','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',13088,0,0,0),(13476,'({TRIGGER.VALUE}=0&{13118}>75)|({TRIGGER.VALUE}=1&{13118}>65)','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',13089,0,0,0),(13477,'({TRIGGER.VALUE}=0&{13120}>75)|({TRIGGER.VALUE}=1&{13120}>65)','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',13275,0,0,0),(13478,'({TRIGGER.VALUE}=0&{13122}>75)|({TRIGGER.VALUE}=1&{13122}>65)','Zabbix node watcher processes more than 75% busy','',0,0,3,0,'','',13090,0,0,0),(13479,'({TRIGGER.VALUE}=0&{13124}>75)|({TRIGGER.VALUE}=1&{13124}>65)','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',13091,0,0,0),(13480,'({TRIGGER.VALUE}=0&{13126}>75)|({TRIGGER.VALUE}=1&{13126}>65)','Zabbix proxy poller processes more than 75% busy','',0,0,3,0,'','',13092,0,0,0),(13481,'({TRIGGER.VALUE}=0&{13030}>75)|({TRIGGER.VALUE}=1&{13030}>65)','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',13093,0,0,0),(13482,'({TRIGGER.VALUE}=0&{13128}>75)|({TRIGGER.VALUE}=1&{13128}>65)','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',13441,0,0,0),(13483,'({TRIGGER.VALUE}=0&{13130}>75)|({TRIGGER.VALUE}=1&{13130}>65)','Zabbix timer processes more than 75% busy','',0,0,3,0,'','',13094,0,0,0),(13484,'({TRIGGER.VALUE}=0&{13132}>75)|({TRIGGER.VALUE}=1&{13132}>65)','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',13095,0,0,0),(13485,'({TRIGGER.VALUE}=0&{13134}>75)|({TRIGGER.VALUE}=1&{13134}>65)','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',13096,0,0,0),(13486,'{12895}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',13023,0,0,0),(13487,'{12896}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',13015,0,0,0),(13488,'{12897}<25','Less than 25% free in the history cache','',0,0,3,0,'','',13073,0,0,0),(13489,'{12898}<25','Less than 25% free in the text history cache','',0,0,3,0,'','',13017,0,0,0),(13490,'{12899}<25','Less than 25% free in the trends cache','',0,0,3,0,'','',13019,0,0,0),(13491,'{12900}=1','Zabbix agent on {HOST.NAME} is unreachable for 5 minutes','',0,0,3,0,'','',10047,0,0,0),(13492,'{12928}>0','Version of zabbix_agent(d) was changed on {HOST.NAME}','',0,0,1,0,'','',10045,0,0,0),(13493,'{12902}<1024','Configured max number of opened files is too low on {HOST.NAME}','',0,0,1,0,'','',10042,0,0,0),(13494,'{12903}<256','Configured max number of processes is too low on {HOST.NAME}','',0,0,1,0,'','',10041,0,0,0),(13495,'{13085}>30','Too many processes running on {HOST.NAME}','',0,0,2,0,'','',10011,0,0,0),(13496,'{13083}>300','Too many processes on {HOST.NAME}','',0,0,2,0,'','',10190,0,0,0),(13497,'{13079}>5','Processor load is too high on {HOST.NAME}','',0,0,2,0,'','',10010,0,0,0),(13498,'{13081}>20','Disk I/O is overloaded on {HOST.NAME}','',0,0,2,0,'OS spends significant time waiting for I/O (input/output) operations. It could be indicator of performance issues with storage system.','',13243,0,0,0),(13499,'{12908}>0','Hostname was changed on {HOST.NAME}','',0,0,1,0,'','',10043,0,0,0),(13500,'{12909}<50','Lack of free swap space on {HOST.NAME}','',0,0,2,0,'It probably means that the systems requires more physical memory.','',10012,0,0,0),(13501,'{12910}>0','Host information was changed on {HOST.NAME}','',0,0,1,0,'','',10044,0,0,0),(13502,'{12911}<0','{HOST.NAME} has just been restarted','',0,0,1,0,'','',10021,0,0,0),(13503,'{12912}>0','/etc/passwd has been changed on {HOST.NAME}','',0,0,2,0,'','',10016,0,0,0),(13504,'{12913}<20M','Lack of available memory on server {HOST.NAME}','',0,0,3,0,'','',13000,0,0,0),(13505,'{12914}<20','Free inodes is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13272,0,0,2),(13506,'{12915}<20','Free disk space is less than 20% on volume {#FSNAME}','',0,0,2,0,'','',13266,0,0,2),(13507,'{12936}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',NULL,0,0,0),(13508,'{12937}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13509,'{12938}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13508,0,0,0),(13510,'{12939}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13511,'{12940}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13512,'{12941}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13513,'{12942}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13514,'{12943}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13515,'{12944}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13516,'{12945}>0','Host name of zabbix_agentd was changed on {HOST.NAME}','',0,0,1,0,'','',13507,0,0,0),(13517,'{12946}<25','Less than 25% free in the configuration cache','',0,0,3,0,'Consider increasing CacheSize in the zabbix_server.conf configuration file','',NULL,0,0,0),(13518,'{12947}<25','Less than 25% free in the history cache','',0,0,3,0,'','',NULL,0,0,0),(13519,'{12948}<25','Less than 25% free in the text history cache','',0,0,3,0,'','',NULL,0,0,0),(13520,'{12949}>100','More than 100 items having missing data for more than 10 minutes','',0,0,2,0,'zabbix[queue,10m] item is collecting data about how many items are missing data for more than 10 minutes (next parameter)','',NULL,0,0,0),(13521,'({TRIGGER.VALUE}=0&{13137}>75)|({TRIGGER.VALUE}=1&{13137}>65)','Zabbix configuration syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13522,'({TRIGGER.VALUE}=0&{13139}>75)|({TRIGGER.VALUE}=1&{13139}>65)','Zabbix discoverer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13523,'({TRIGGER.VALUE}=0&{13141}>75)|({TRIGGER.VALUE}=1&{13141}>65)','Zabbix history syncer processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13524,'({TRIGGER.VALUE}=0&{13142}>75)|({TRIGGER.VALUE}=1&{13142}>65)','Zabbix housekeeper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13525,'({TRIGGER.VALUE}=0&{13143}>75)|({TRIGGER.VALUE}=1&{13143}>65)','Zabbix http poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13526,'({TRIGGER.VALUE}=0&{13144}>75)|({TRIGGER.VALUE}=1&{13144}>65)','Zabbix icmp pinger processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13527,'({TRIGGER.VALUE}=0&{13145}>75)|({TRIGGER.VALUE}=1&{13145}>65)','Zabbix ipmi poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13528,'({TRIGGER.VALUE}=0&{13146}>75)|({TRIGGER.VALUE}=1&{13146}>65)','Zabbix java poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13529,'({TRIGGER.VALUE}=0&{13147}>75)|({TRIGGER.VALUE}=1&{13147}>65)','Zabbix poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13530,'({TRIGGER.VALUE}=0&{13148}>75)|({TRIGGER.VALUE}=1&{13148}>65)','Zabbix self-monitoring processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13531,'({TRIGGER.VALUE}=0&{13149}>75)|({TRIGGER.VALUE}=1&{13149}>65)','Zabbix snmp trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13532,'({TRIGGER.VALUE}=0&{13150}>75)|({TRIGGER.VALUE}=1&{13150}>65)','Zabbix trapper processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13533,'({TRIGGER.VALUE}=0&{13151}>75)|({TRIGGER.VALUE}=1&{13151}>65)','Zabbix unreachable poller processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13534,'({TRIGGER.VALUE}=0&{13138}>75)|({TRIGGER.VALUE}=1&{13138}>65)','Zabbix data sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13535,'({TRIGGER.VALUE}=0&{13140}>75)|({TRIGGER.VALUE}=1&{13140}>65)','Zabbix heartbeat sender processes more than 75% busy','',0,0,3,0,'','',NULL,0,0,0),(13536,'{12965}<25','Less than 25% free in the vmware cache','',0,0,3,0,'','',NULL,0,0,0),(13537,'{12966}<25','Less than 25% free in the vmware cache','',0,0,3,0,'','',13536,0,0,0),(13538,'{12968}>0.7','70% os Process CPU Load on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13539,'{12969}>({12970}*0.7)','70% mem Heap Memory used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13540,'{12971}>({12972}*0.7)','70% mem Non-Heap Memory used on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13541,'{12973}={12974}','mem Heap Memory fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13542,'{12975}={12976}','mem Non-Heap Memory fully committed on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13543,'{12977}#1','{HOST.NAME} runs suboptimal VM type','',0,0,1,0,'','',NULL,0,0,0),(13544,'{12994}=0','FTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13545,'{12995}=0','HTTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13546,'{12996}=0','HTTPS service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13547,'{12997}=0','IMAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13548,'{12998}=0','LDAP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13549,'{13154}=0','NNTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13550,'{13156}=0','NTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13551,'{13152}=0','POP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13552,'{13157}=0','SMTP service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13553,'{13158}=0','SSH service is down on {HOST.NAME}','',0,0,3,0,'','',NULL,0,0,0),(13554,'{13096}=0','{HOST.NAME} is unavailable by ICMP','',0,0,3,0,'','',NULL,0,0,0),(13555,'{13097}>0.15','Response time is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0),(13556,'{13098}>20','Ping loss is too high on {HOST.NAME}','',0,0,2,0,'','',NULL,0,0,0);
/*!40000 ALTER TABLE `triggers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_history`
--

DROP TABLE IF EXISTS `user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_history` (
  `userhistoryid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `title1` varchar(255) NOT NULL DEFAULT '',
  `url1` varchar(255) NOT NULL DEFAULT '',
  `title2` varchar(255) NOT NULL DEFAULT '',
  `url2` varchar(255) NOT NULL DEFAULT '',
  `title3` varchar(255) NOT NULL DEFAULT '',
  `url3` varchar(255) NOT NULL DEFAULT '',
  `title4` varchar(255) NOT NULL DEFAULT '',
  `url4` varchar(255) NOT NULL DEFAULT '',
  `title5` varchar(255) NOT NULL DEFAULT '',
  `url5` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`userhistoryid`),
  UNIQUE KEY `user_history_1` (`userid`),
  CONSTRAINT `c_user_history_1` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_history`
--

LOCK TABLES `user_history` WRITE;
/*!40000 ALTER TABLE `user_history` DISABLE KEYS */;
INSERT INTO `user_history` VALUES (1,1,'','','','','Dashboard','dashboard.php','Configuration of hosts','hosts.php?groupid=0','Configuration of actions','actionconf.php');
/*!40000 ALTER TABLE `user_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `userid` bigint(20) unsigned NOT NULL,
  `alias` varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `surname` varchar(100) NOT NULL DEFAULT '',
  `passwd` char(32) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `autologin` int(11) NOT NULL DEFAULT '0',
  `autologout` int(11) NOT NULL DEFAULT '900',
  `lang` varchar(5) NOT NULL DEFAULT 'en_GB',
  `refresh` int(11) NOT NULL DEFAULT '30',
  `type` int(11) NOT NULL DEFAULT '1',
  `theme` varchar(128) NOT NULL DEFAULT 'default',
  `attempt_failed` int(11) NOT NULL DEFAULT '0',
  `attempt_ip` varchar(39) NOT NULL DEFAULT '',
  `attempt_clock` int(11) NOT NULL DEFAULT '0',
  `rows_per_page` int(11) NOT NULL DEFAULT '50',
  PRIMARY KEY (`userid`),
  KEY `users_1` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Admin','Zabbix','Administrator','5fce1b3e34b520afeffb37ce08c7cd66','',1,0,'en_GB',30,3,'default',0,'',0,50),(2,'guest','','','d41d8cd98f00b204e9800998ecf8427e','',0,900,'en_GB',30,1,'default',0,'',0,50);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_groups` (
  `id` bigint(20) unsigned NOT NULL,
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_groups_1` (`usrgrpid`,`userid`),
  KEY `users_groups_2` (`userid`),
  CONSTRAINT `c_users_groups_2` FOREIGN KEY (`userid`) REFERENCES `users` (`userid`) ON DELETE CASCADE,
  CONSTRAINT `c_users_groups_1` FOREIGN KEY (`usrgrpid`) REFERENCES `usrgrp` (`usrgrpid`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_groups`
--

LOCK TABLES `users_groups` WRITE;
/*!40000 ALTER TABLE `users_groups` DISABLE KEYS */;
INSERT INTO `users_groups` VALUES (4,7,1),(2,8,2);
/*!40000 ALTER TABLE `users_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usrgrp`
--

DROP TABLE IF EXISTS `usrgrp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usrgrp` (
  `usrgrpid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  `gui_access` int(11) NOT NULL DEFAULT '0',
  `users_status` int(11) NOT NULL DEFAULT '0',
  `debug_mode` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usrgrpid`),
  KEY `usrgrp_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usrgrp`
--

LOCK TABLES `usrgrp` WRITE;
/*!40000 ALTER TABLE `usrgrp` DISABLE KEYS */;
INSERT INTO `usrgrp` VALUES (7,'Zabbix administrators',0,0,0),(8,'Guests',0,0,0),(9,'Disabled',0,1,0),(11,'Enabled debug mode',0,0,1),(12,'No access to the frontend',2,0,0);
/*!40000 ALTER TABLE `usrgrp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `valuemaps`
--

DROP TABLE IF EXISTS `valuemaps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `valuemaps` (
  `valuemapid` bigint(20) unsigned NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`valuemapid`),
  KEY `valuemaps_1` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `valuemaps`
--

LOCK TABLES `valuemaps` WRITE;
/*!40000 ALTER TABLE `valuemaps` DISABLE KEYS */;
INSERT INTO `valuemaps` VALUES (4,'APC Battery Replacement Status'),(5,'APC Battery Status'),(7,'Dell Open Manage System Status'),(2,'Host status'),(6,'HP Insight System Status'),(1,'Service state'),(9,'SNMP device status (hrDeviceStatus)'),(11,'SNMP interface status (ifAdminStatus)'),(8,'SNMP interface status (ifOperStatus)'),(13,'VMware status'),(12,'VMware VirtualMachinePowerState'),(3,'Windows service state'),(10,'Zabbix agent ping status');
/*!40000 ALTER TABLE `valuemaps` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-17 10:55:36