#!/bin/bash
while true
do
	clear
	#ROOT ZSH	
	docker exec nft_store bash -c "echo "$date" > /mnt/monitoring/history_zsh_root.txt"
	docker exec nft_store bash -c "echo "$(cat /root/.zsh_history | cut -c16-)" > /mnt/monitoring/history_zsh_root.txt"
	echo -e "\033[32m ::: ROOT ZSH ::: \033[0m\n"
#	docker exec nft_store bash -c "cat /mnt/monitoring/history_zsh_root.txt | tail -n 50"
	docker exec nft_store bash -c "tail -f /root/.zsh_history"
	sleep 5
done
