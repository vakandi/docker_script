#!/bin/bash
while true
do
	clear
	#ROOT BASH
	docker exec nft_store bash -c "echo "$date" > /mnt/monitoring/history_bash_root.txt"
	docker exec nft_store bash -c "cat /root/.bash_history > /mnt/monitoring/history_bash_root.txt"
	echo -e "\033[32m ::: ROOT BASH ::: \033[0m\n"
	docker exec nft_store bash -c "tail -f /root/.bash_history"
	#docker exec nft_store bash -c "cat /mnt/monitoring/history_bash_root.txt | tail -n 50"
	sleep 5
done
