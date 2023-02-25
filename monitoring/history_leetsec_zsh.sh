#!/bin/bash
while true
do
	clear
	#LEETSEC ZSH
	docker exec nft_store bash -c "echo "$date" > /mnt/monitoring/history_zsh_leetsec.txt"
	docker exec nft_store bash -c "echo "$(cat /home/leetsec/.zsh_history | cut -c16-)" > /mnt/monitoring/history_zsh_leetsec.txt"
	echo -e "\033[32m ::: LEETSEC ZSH ::: \033[0m\n"
	docker exec nft_store bash -c "tail -f /home/leetsec/.zsh_history"
	#docker exec nft_store bash -c "cat /mnt/monitoring/history_zsh_leetsec.txt | tail -n 50"
	sleep 5
done
