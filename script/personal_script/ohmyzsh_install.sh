#!/bin/sh
check_zsh="$(dpkg --list | grep zsh)"
check_git="$(dpkg --list | grep git)"
if [ -z "$check_zsh" ]
then
	echo 'zsh is not installed'
	echo 'Installing zsh now..'
	sudo apt install zsh -y
else
	echo 'zsh is installed\n'
fi
if ! [ -x "$(command -v git)" ]; then
	echo 'git is not installed'
	echo 'Installing git now..'
	sudo apt install git -y
else
	echo 'git is installed\n'
fi
if ! [ -x "$(command -v curl)" ]; then
	echo "curl not found, using wget..."
	sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
else
	echo "curl found, using it..."
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
