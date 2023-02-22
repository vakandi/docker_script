#!/bin/bash

# Get the current user
currentUser=$(ls -l /dev/console | awk '{print $3}')

# Set the keyboard settings to maximum key repeat and delay until repeat
sudo -u $currentUser defaults write -g InitialKeyRepeat -int 15
sudo -u $currentUser defaults write -g KeyRepeat -int 2

# Set the mouse settings to non-natural scrolling and a speed of 75%
sudo -u $currentUser defaults write -g com.apple.swipescrolldirection -bool false
sudo -u $currentUser defaults write -g com.apple.mouse.scaling -float 0.75

# Restart Finder to apply changes
killall Finder

