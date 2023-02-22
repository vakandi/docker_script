#!/bin/sh
docker run -it --entrypoint bash $(docker ps -a | awk '{ print $2 }' |sed '1d' |head -n 1)
