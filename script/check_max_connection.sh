#!/bin/sh

MAX_CONNECTIONS=20
INTERVAL=5
LOG_FILE="/var/log/apache2/access.log"
IPTABLES="sudo iptables -A INPUT -m mac --mac-source"
BLOCKED_MAC_FILE="/tmp/blocked_macaddress.txt"

while true; do
  CONNECTIONS=$(tail -n 1000 $LOG_FILE | awk -v date="$(date +[%d/%b/%Y:%H:%M])" '$4 >= date {print $1}' | sort | uniq -c | awk '{print $2 " " $1}')

  while read -r LINE; do
    MAC="$(echo $LINE | awk '{print $1}')"
    COUNT="$(echo $LINE | awk '{print $2}')"

    if [ "$COUNT" -gt "$MAX_CONNECTIONS" ]; then
      $IPTABLES $MAC -j DROP
      echo "$MAC" >> $BLOCKED_MAC_FILE
      echo "Blocked MAC address: $MAC with $COUNT connections" | wall
      (sleep 120 && sudo iptables -D INPUT -m mac --mac-source $MAC -j DROP && sed -i "/^$MAC$/d" $BLOCKED_MAC_FILE) &
    fi
  done <<< "$CONNECTIONS"

  sleep "$INTERVAL"
done
