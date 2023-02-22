#!/bin/sh
rm -rf .tmp
var=1
LOOP="$(ls -l *.c | awk '{print $9}' | wc -l)"
sum=$(($var - 1))
file_sum=$(ls -l *.c | awk '{print $9}' | head -n $sum |tail -1)

rm -rf .tmp
mkdir .tmp

SCRIPT=.tmp/vakandi_norm$RANDOM.py

while [ $var -le $LOOP ]
do
	echo "$(cat vakandi_norm.py | perl -pe "s#FILE#$(ls -l *.c | awk '{print $9}' | head -n $var |tail -1)#")" > $SCRIPT
	echo "Python script is running.."
	python3 $SCRIPT
	 echo "\033[1;44m$(ls -l *.c | awk '{print $9}' | head -n $var |tail -1)_fix.txt Done..\033[0m"
	var=$((var+1))
done

begin=1

echo "First Norminette loop done"
echo "Clean Norm file have been created under the same *_fix.txt"
echo "Cleaning the Temporary Norm file"
echo "Removing old .c files"
rm *.c
echo "\033[1;44mDone\033[0m"
echo "Creating the new .c files:"

while [ $begin -le $var ]
do
	OLD=$(ls -l *_fix.txt | awk '{print $9}' | head -n $begin |tail -1)
	NEW=$(echo "$OLD" | sed 's/_fix.txt//g')
	mv $OLD $NEW
	echo "\033[1;44m$OLD was changed to $NEW\033[0m"
	echo "Done..."
	begin=$((begin+1))
done

rm -rf .tmp
echo ".c File have been cleaned and restored"
rm -f vakandi_norm.sh
rm -f vakandi_norm.py
echo "The script .sh and .py have been removed"

echo "Finished"
