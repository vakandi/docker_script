#!/bin/sh
docker tag debian:bullseye waelbousfira/hackathon_full:latest 
#docker build -t waelbousfira/hackathon_full:latest .
docker commit nft_store waelbousfira/hackathon_full:latest
docker push waelbousfira/hackathon_full:latest
