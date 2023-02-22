#!/bin/bash
MAX_CONNECTIONS=15

INTERVAL=5

LOG_FILE="/var/log/apache2/access.log"

while true; do
  # Get a list of unique MAC addresses and their number of connections in the last minute
  CONNECTIONS=$(tail -n 1000 $LOG_FILE | awk -v date="$(date +[%d/%b/%Y:%H:%M)" '$4 >= date {print $1}' | sort | uniq -c | awk '{print $2 " " $1}')

  while read -r LINE; do
    MAC="$(echo $LINE | awk '{print $1}')"
    COUNT="$(echo $LINE | awk '{print $2}')"

    if [ $COUNT -gt $MAX_CONNECTIONS ]; then
      echo "HIGH ($COUNT) NUMBER OF REQUESTS FROM: $MAC" | wall
    fi
  done <<< "$CONNECTIONS"

  sleep $INTERVAL
done
