#!/bin/bash

# Check if the user passed the filename as an argument
if [ $# -eq 0 ]; then
  echo "Error: Please specify the name of the tar file to load."
  exit 1
fi

filename=$1
container_name="$(basename "$filename" .tar)"

# Load the saved tar file to create a new Docker container
docker import "$filename" "$container_name"

# Start the newly created container
docker start "$container_name"

echo "Container $container_name has been started from $filename"

