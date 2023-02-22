#!/bin/bash

# Check if the required tools are installed
if ! command -v ffmpeg > /dev/null 2>&1; then
  echo "ffmpeg is not installed. Please install it and try again."
  exit 1
fi

if ! command -v jp2a > /dev/null 2>&1; then
  echo "jp2a is not installed. Please install it and try again."
  exit 1
fi

# Check if a file is given as input
if [ $# -eq 0 ]; then
  echo "No file specified. Please provide a file in .mp4 format as input."
  exit 1
fi

# Check if the given file is in .mp4 format
if [ "${1##*.}" != "mp4" ]; then
  echo "Invalid file format. Please provide a file in .mp4 format."
  exit 1
fi

# Extract frames from the video at a rate of 10 frames per second
ffmpeg -i "$1" -vf fps=10 frame%04d.jpg -hide_banner

# Convert each frame to ASCII art and display on the terminal
for file in frame*.jpg; do
  clear # clear the terminal
  jp2a --color --width=$(tput cols) "$file"
  printf "\033[1A"
  rm "$file"
  sleep 0.1 # pause for 0.1 seconds before displaying the next frame
done 

