#!/bin/bash

tmux new-session -d
tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux split-window -v

tmux select-pane -t 0
tmux send-keys 'sh top_left.sh' C-m
tmux select-pane -t 1
tmux send-keys 'sh top_right.sh' C-m
tmux select-pane -t 2
tmux send-keys 'bash bottom_left.sh' C-m
tmux select-pane -t 3
tmux send-keys 'sh bottom_right.sh' C-m

tmux attach-session -d
