#!/bin/sh
systemctl stop apache2
systemctl stop mariadb

docker_path='/root/leetsec_hackathons/webpentest'
mount_point='/mnt'

docker pull debian:bullseye
docker build -t debian:bullseye .
docker run -p 80:80 -p 42:42 -it -d --name nft_store -v $docker_path:$mount_point/ debian:bullseye bash
#docker run -p 80:80 -p 22:22 -it --name nft_store -v /root/hackathons-webpentest-challenge/hackaton-v2/docker:/mnt/ debian:bullseye bash
echo " "
echo "\033[42m DOCKER STARTED \033[0m"
echo " "
docker exec nft_store bash -c "bash /mnt/docker_script/setup.sh"
