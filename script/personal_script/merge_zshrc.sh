#!/bin/sh
CURRENT=$(cat ~/.zshrc | grep "\S" | sed '1,5d' | sed '$ d' | sed '$ d'| sed '$ d'| sed '$ d'| sed '$ d')
LINUX=$(cat ~/script/zshrclinux | grep "\S" | sed '1,6d' | sed '$ d' | sed '$ d'| sed '$ d'| sed '$ d'| sed '$ d')
MAC=$(cat ~/script/zshrcmac | grep "\S" | sed '1,6d' | sed '$ d' | sed '$ d'| sed '$ d'| sed '$ d'| sed '$ d')
TERMUX=$(cat ~/script/zshrctermux | grep "\S" | sed '1,5d' | sed '$ d' | sed '$ d'| sed '$ d'| sed '$ d'| sed '$ d')
WSL=$(cat ~/script/zshrclinux-acer | grep "\S" | sed '1,6d' | sed '$ d' | sed '$ d'| sed '$ d'| sed '$ d'| sed '$ d')
NUMBER_ALIAS=$(cat ~/.zshrc | grep "\S" | sed '1,5d' | sed '$ d' | sed '$ d'| sed '$ d'| sed '$ d'| sed '$ d'| wc -l)

echo "\033[35;mGit pulling the zshrc from ~/script\033[0m"
cd ~/script
git pull
echo "\n"

echo "\033[43;mNumber of Alias in your zshrc : $NUMBER_ALIAS\033[0m" 

echo "$CURRENT" > ~/.zshrc.tmp
echo "$TERMUX" >> ~/.zshrc.tmp
echo "$LINUX" >> ~/.zshrc.tmp
echo "$MAC" >> ~/.zshrc.tmp
echo "$WSL" >> ~/.zshrc.tmp

echo "All zshrc have been regroup into .zshrc.tmp file\n"
echo "" > ~/.zshrc.tmp2

echo "temp file .zshrc.tmp2 has been cleaned\n"
echo "$(cat ~/.zshrc | grep "\S" | head -n5)" > ~/.zshrc.tmp2

echo "Sorting the double line\n"
echo "$(cat ~/.zshrc.tmp | sort -u | uniq -w 11)" >> ~/.zshrc.tmp2

echo "Putting special zsh style code\n"
echo "$(cat ~/.zshrc | grep "\S" | tail -n5)" >> ~/.zshrc.tmp2

echo "\033[35;mNumber of Alias BEFORE: $NUMBER_ALIAS\033[0m\n AFTER: \033[34;m$(cat ~/.zshrc.tmp2 | grep "\S" | sed '1,5d' | sed '$ d'| sed '$ d'| sed '$ d'| sed '$ d' | sed '$ d'| wc -l)\033[0m"

DATE="$(echo $(date) | cut -c5-9 | tr " " "_")"
read input
if [ $input = "y" ]; then
	echo "Backup the current zshrc into ~/.zshrc_backup$DATE"
	cp ~/.zshrc ~/.zshrc_backup$DATE
	echo "Removing the current ~/.zshrc into"
	cp ~/.zshrc.tmp2 ~/.zshrc
	echo "Removing the temporary file ~/.zshrc.tmp"
	rm ~/.zshrc.tmp*
else
	echo "Removing the temporary file ~/.zshrc.tmp"
	rm ~/.zshrc.tmp
	echo "Merge everything into ~/.zshrc.tmp"
	cp ~/.zshrc.tmp2 ~/.zshrc.tmp
	echo "The new zshrc is store in ~/.zshrc.tmp" 
fi
echo "\033[42;mMerging Done\033[0m"
