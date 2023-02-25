#!/bin/sh
RED='\033[0;36m'
BLUE='\033[0;35m'
GREEN='\033[0;32m'
BACK_GREEN='\033[0;42m'
BACK_PURPLE='\033[0;45m'
PURPLE='\033[0;35m'
ORANGE='\033[0;33m'
END='\033[0m'
container_name="nft_store"
#while true
#do
	# Get the last 20 access logs and extract the IP and browser info only
	#ps_output=$(docker exec $container_name sh -c "tail -f -n 20 /var/log/apache2/access.log | awk '{print \$1,\$12}'")
	ps_output=$(docker exec $container_name sh -c "lnav /var/log/apache2/error.log")
	echo "Apache2 Error Log: "
	echo "$ps_output"
#	sleep 2s
#done

