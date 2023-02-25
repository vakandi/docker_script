#!/bin/bash
container_id=$(docker container ls -q)
container_hostname=$(docker inspect -f '{{ .Config.Hostname }}' $container_id)
container_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id)
username="leetsec"
port="42"
ssh_password="leetsec***"
#read -s -p "Enter SSH password: " ssh_password

echo "Setup History config.."

#setup ohmyzsh on leetsec
echo "Installing ohmyzsh.."
sshpass -p $ssh_password ssh -p $port $username@$container_ip "sh /home/leetsec/script/ohmyzsh_install_no_read.sh &"
sleep 3

echo "Give permissions to the history files.."
docker exec nft_store bash -c "chown leetsec:leetsec /mnt/monitoring/history*"

echo "Setup bash history with "set -o history" for leetsec"
sshpass -p $ssh_password ssh -p $port $username@$container_ip "set -o history"
sleep 0.1
echo "Setup bash history with "set -o history" for root"
docker exec nft_store bash -c "set -o history"

echo "Running "history -r ~/bash_history" command .. for leetsec"
sshpass -p $ssh_password ssh -p $port $username@$container_ip "history -r ~/.bash_history"
sleep 0.1
echo "Running "history -r ~/bash_history" command .. for root"
docker exec nft_store bash -c "history -r ~/.bash_history"
echo "Setup Finished"

echo "Launching tmux session.."

#ROOT ZSH	
#echo "Updating history files.."; docker exec nft_store bash -c "echo "$date" >> /mnt/history_zsh_root.txt"; echo "Getting root history.."; docker exec nft_store bash -c "echo "$(cat /root/.zsh_history | cut -c16-)" >> /mnt/history_zsh_root.txt"; echo "Finished.."; docker exec nft_store bash -c "cat /mnt/history_zsh_root.txt | tail -n 50";

#ROOT BASH
#echo "Updating history files.."; docker exec nft_store bash -c "echo "$date" >> /mnt/history_bash_root.txt"; echo "Getting root history.."; docker exec nft_store bash -c "cat /root/.bash_history >> /mnt/history_bash_root.txt"; echo "Finished.."; docker exec nft_store bash -c "cat /mnt/history_bash_root.txt | tail -n 50";


#LEETSEC ZSH
#echo "Updating history files.."; docker exec nft_store bash -c "echo "$date" >> /mnt/history_zsh_leetsec.txt"; echo "Getting leetsec history.."; docker exec nft_store bash -c "echo "$(cat /home/leetsec/.zsh_history | cut -c16-)" >> /mnt/history_zsh_leetsec.txt"; echo "Finished.."; docker exec nft_store bash -c "cat /mnt/history_zsh_leetsec.txt | tail -n 50";

#LEETSEC BASH
#echo "Updating history files.."; docker exec nft_store bash -c "echo "$date" >> /mnt/history_bash_leetsec.txt"; echo "Getting leetsec history.."; docker exec nft_store bash -c "cat /home/leetsec/.bash_history >> /mnt/history_bash_leetsec.txt"; docker exec nft_store bash -c "echo "$(cat /home/leetsec/.zsh_history | cut -c16-)" >> /mnt/history_bash_leetsec.txt"; echo "Finished.."; docker exec nft_store bash -c "cat /mnt/history_bash_leetsec.txt | tail -n 50";

tmux new-session -d
tmux split-window -h -p 75
tmux split-window -h -p 65
tmux split-window -h -p 55
tmux select-pane -t 0

tmux send-keys -t 0 'bash history_leetsec_bash.sh' C-m
tmux send-keys -t 1 'bash history_leetsec_zsh.sh' C-m
tmux send-keys -t 2 'bash history_root_bash.sh' C-m
tmux send-keys -t 3 'bash history_root_zsh.sh' C-m



tmux attach-session   
