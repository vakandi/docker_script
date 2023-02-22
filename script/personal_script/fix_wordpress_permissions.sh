loops="$(find . -type f -name "*.php" | cut -c3- | wc -l)"
var=1
echo "" > .wrong_permissions.txt
echo "\033[34mSTARTING WITH FILE PERMISSIONS:::\033[0m"
while [ $var -le $loops ]
do
	chmod 644 $php_files
	echo "\033[34mDONE for $php_files\033[0m"
	var=$((var+1))
	php_files="$(find . -type f -name "*.php" | cut -c3- | head -n$var | tail -n 1)"
done
var=1
while [ $var -le $loops ]
do
	php_files1="$(find . -type f -name "*.php" | cut -c3- | head -n$var | tail -n 1)"
	permissions="$(stat -L  -c "%a %G %U" $php_files1 | awk '{print $1}')"
	echo "\033[36mChecking Permissions for $php_files1\033[0m"
	if [ $permissions = "644" ]; then
		echo "\033[32mGood Permissions for $php_files1\n\033[0m"
	else
		echo "\033[31mWrong Permissions for $php_files1\n VERIFY THIS FILES\033[0m"
		echo "$php_files1" >> .wrong_permissions.txt
	fi
	var=$((var+1))
done
var2=$var
echo "\033[31mNUMBER OF FILES CHECKED ::: $var2 \033[0m"
var=1
loopsF="$(find . -type d | sed '1d' | cut -c3- | wc -l)"
echo "\033[34mSTARTING WITH FOLDER PERMISSIONS:::\033[0m"
while [ $var -le $loopsF ]
do
	php_files2="$(find . -type d | sed '1d' | cut -c3- | head -n$var | tail -n 1)"
	chmod 755 $php_files2
	echo "\033[34mDONE for $php_files2\n LOOPS $var\033[0m"
	var=$((var+1))
done
var=1
while [ $var -le $loopsF ]
do
	php_files3="$(find . -type d | sed '1d' | cut -c3- | head -n$var | tail -n 1)"
	permissions1="$(stat -L  -c "%a %G %U" $php_files3 | awk '{print $1}')"
	echo "\033[36mChecking Permissions for $php_files3\033[0m"
	if [ $permissions = "644" ]; then
		echo "\033[32mGood Permissions for $php_files3\n\033[0m"
	else
		echo "\033[31mWrong Permissions for $php_files3\n VERIFY THIS FOLDER\033[0m"
		echo "$php_files3" >> .wrong_permissions.txt
	fi
	var=$((var+1))
done
echo "\033[35mNUMBER OF FOLDERS CHECKED ::: $var2 \033[0m"
echo "\033[35mNUMBER OF FILES CHECKED ::: $var \033[0m"

echo "\033[34mChecking for any error during the script.....\033[0m"
wrong_files="$(cat .wrong_permissions.txt)"
if [ -z $wrong_files ]
then
	echo "\033[34mEvery files has the right permissions, everythings checked out\033[0m"
else
	echo "\033[31mThis Files have problem with their permissions and the script didn't successfully change them\033[0m"
	echo "\033[31m$(cat .wrong_permissions.txt)m\033[0m"
fi
rm .wrong_permissions.txt
