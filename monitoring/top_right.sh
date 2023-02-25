#!/bin/sh
RED='\033[0;36m'
BLUE='\033[0;35m'
GREEN='\033[0;32m'
BACK_GREEN='\033[0;42m'
BACK_PURPLE='\033[0;45m'
PURPLE='\033[0;35m'
ORANGE='\033[0;33m'
END='\033[0m'  

# Create a new tmux session and split it into two panes
tmux new-session -d 'top -U' \; split-window -h 'top -U'

while true; do
clear
	# Get a list of all non-root processes and print them with their associated user
	nonroot_processes=$(ps aux | awk '$1!="root" {print $1 " : " $11}')
	nonroot_sorted=$(echo "$nonroot_processes" | sort -k 3 -rn)
	
	# Get the biggest process
	biggest_process=$(echo "$nonroot_sorted" | head -n 1 | awk '{print $2}')
	
	# Print the non-root processes, highlighting the biggest one in blue
	echo "$nonroot_sorted" | while read line; do
	if [[ "$line" == *" $biggest_process"* ]]; then
		echo -e "\033[34m$line\033[0m"
	elif [[ "$(echo $line | awk '{print $9}')" -gt $((5*60)) ]]; then
		echo -e "\033[32m$line\033[0m"
	else
	echo "$line"
	fi
	done | column -t -s ":"
	
	# Get a list of all root processes and print recent ones in green
	root_processes=$(ps aux | awk '$1=="root" {print $11, $9}')
	echo "$root_processes" | while read line; do
	if [[ "$(echo $line | awk '{print $2}')" -lt $((5*60)) ]]; then
		echo -e "\033[32m$line\033[0m"
	else
		echo "$line"
	fi
	done | column -t
	sleep 1
done

