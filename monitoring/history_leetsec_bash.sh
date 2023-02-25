#!/bin/bash

while true
do
	clear
	#LEETSEC BASH
	docker exec nft_store bash -c "echo "$date" > /mnt/monitoring/history_bash_leetsec.txt"
	docker exec nft_store bash -c "cat /home/leetsec/.bash_history > /mnt/monitoring/history_bash_leetsec.txt"
	echo -e "\033[32m ::: LEETSEC BASH ::: \033[0m\n"
	docker exec nft_store bash -c "tail -f /home/leetsec/.bash_history"
	#docker exec nft_store bash -c "cat /mnt/monitoring/history_bash_leetsec.txt | tail -n 50"
	sleep 5
done
