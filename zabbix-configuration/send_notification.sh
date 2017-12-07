#!/bin/bash

# This script sends a POST request to the Zabbix Plugin.
# If it fails, it logs the reason in the log file
# Arguments:
# "to" is the Zabbix Plugin endpoint
# "body" is the information about the trigger as JSON

to=$1
body=$3
log_file=/var/log/zabbix/send_notification.log

output=`curl -f -X POST -H "Content-Type: application/json" -d "$body" http://$to 2>&1`
exit_status=$?

if test "$exit_status" != "0"; then
   echo "" >> $log_file
   echo "$(date): curl failed to send notification with error: $exit_status" >> $log_file
   echo "$output" >> $log_file
   echo "Destination: $to" >> $log_file
   echo "Notification body: $body" >> $log_file
fi

