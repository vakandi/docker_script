#!/bin/sh
loops=$(ls -l *.php | wc -l)
var=1
while [ $var -le $loops ]
do
	file=$(ls -l *.php | awk '{ print $9 }' |head -n $var |tail -n1)
	echo "$(cat $file | sed "s#author-profile.html#author-profile.php#g")" > $file
	echo "$(cat $file | sed "s#authors.html#authors.php#g")" > $file
	echo "$(cat $file | sed "s#item-details.html#item-details.php#g")" > $file
	echo "$(cat $file | sed "s#auction.html#auction.php#g")" > $file
	echo "$(cat $file | sed "s#add-wallet.html#add-wallet.php#g")" > $file
	echo "$(cat $file | sed "s#discover-1.html#discover-1.php#g")" > $file
	echo "$(cat $file | sed "s#contact.html#contact.php#g")" > $file
	echo "$(cat $file | sed "s#categorieshtml#categories.php#g")" > $file
	echo "$(cat $file | sed "s#register.html#register.php#g")" > $file
	echo "The file $file is done..."
	echo $var 
	var=$((var+1))
done
