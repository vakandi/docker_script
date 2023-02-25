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
while true
do
	clear
	mysql=$(docker exec $container_name bash -c "mysql -u root -e \"USE nftstoredatabase; SELECT * FROM users ORDER BY id DESC LIMIT 50;\"")

	echo "${BLUE}MariaDB real-time info (every request to create a new user in the 'username' table):${END}"
	echo "${GREEN}$mysql${END}"
	sleep 2s
done

