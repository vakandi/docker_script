#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Error: Please specify the name of the container to save."
  exit 1
fi

container_name=$1
filename="${container_name}_16h.tar"

rm -f $filename

docker export "$container_name" > "$filename"

echo "Container $container_name has been saved to $filename"

