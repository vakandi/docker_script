#!/bin/sh

tmux new-session -s monitoring -d

tmux split-window -h
tmux split-window -v
tmux select-pane -t 0
tmux split-window -v

tmux send-keys -t 0 'bash top_left.sh' C-m
tmux send-keys -t 1 'bash top_right.sh' C-m
tmux send-keys -t 2 'bash bottom_left.sh' C-m
tmux send-keys -t 3 'bash bottom_right.sh' C-m

tmux setw -g mode-mouse on
tmux set -g mouse-select-pane on
tmux set -g mouse-resize-pane on
tmux set -g mouse-select-window on
tmux select-pane -t 0
tmux setw -g aggressive-resize on

tmux attach-session -t monitoring

