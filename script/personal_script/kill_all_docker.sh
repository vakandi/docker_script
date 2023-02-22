#!/bin/sh
loops=$(docker ps -a |awk '{ print $1 }' | sed '1d' | wc -l)
var=1

while [ $var -le $loops ]
do
	ID="$(docker ps -a |awk '{ print $1 }' | sed '1d' |head -n $var |tail -n 1)"
	docker rm -f $ID
	echo "Container : $ID \n Removed Successfully"
	var=$((var+1))
done
