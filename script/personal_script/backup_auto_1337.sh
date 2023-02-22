#This script will backup everything in your ~/ without the "FOLDER_TO_EXCLUDE"
#To make the script automatic everytime you logged in 1337, add the line: "nohup ./Users/wbousfir/script/backup-auto.sh" at the last line of your ~/.zshrc
#FOLDER_TO_EXCLUDE="--exclude='>FOLDER<'"
DATE="$(echo $(date) | cut -c5-10 | tr " " "_")"
BACKUPNAME='backup-session-1337-$DATE.tar'
PRIVATE_GIT="https://github.com/vakandi/backup-session-1337.git"
while true
do
	rm -rf ~/.tmp
	mkdir ~/.tmp
	cd ~/.tmp ; git clone $PRIVATE_GIT gcl$DATE; cd gcl$DATE;
	tar --exclude='~/Library' --exclude='~/Desktop' -cvf ~/.tmp/gcl$DATE/$BACKUPNAME .zshrc .___ .oh-my-zsh /usr/bin *
	git add $BACKUPNAME; git commit -m "backup $DATE"; git push	
	#If you prefer using a dmg image to backup, just uncomment the line below
	#hdiutil create -fs HFS+ -srcfolder ~/.tmp/$BACKUPNAME -volname Backup_1337_$DATE backup_session_1337_$DATE.dmg
	sleep 1800s
done
