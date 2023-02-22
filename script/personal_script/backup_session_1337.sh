CHECK_DOUBLE_PROCESS=$(ps -ax | grep backup_auto.sh | awk '{print $1}' |wc -l | cut -c8-)
CHECK_NEW_PROCESS=$(jobs | grep backup_auto.sh | awk '{print $1}' | cut -c2-2)
NUMBER_PROCESS=$(jobs | grep backup_auto.sh | wc -l | cut -c8-)
var=2
var3=3
DATE="$(echo $(date) | cut -c5-10 | tr " " "_")"
PRIVATE_GIT="https://github.com/vakandi/backup-session-1337.git"
#			kill $(ps -ax | grep backup_auto_1337.sh | awk '{print $1}' | tr '\n' ' ') && pkill tar

#if [ "$CHECK_DOUBLE_PROCESS" -eq "$var" ]; then
#exit
#fi
##if [ "$CHECK_DOUBLE_PROCESS" -eq "$var3" ]; then
##	exit
##fi
##	if [[ $CHECK_DOUBLE_PROCESS -le $var ]]; then
if [ $CHECK_NEW_PROCESS -ge "1" ]; then
	kill "%$(jobs | grep backup_auto.sh | awk '{print $1}' | cut -c2-2)"
	exit
fi
while true
do
	#	kill $(ps -ax | grep backup_auto.sh | awk '{print $1}' | tr '\n' ' ') && kill $(ps -ax | grep tar | awk '{print $1}' | tr '\n' ' ')
		cd ~/
		tar --exclude='./.brew' --exclude='./Library' --exclude='./Desktop' --exclude='./.tmp' --exclude='./code/1337RANK.io' --exclude='./Applications' --exclude='./backup-session-1337' -cf backup_session_1337_$DATE.tar * .*
		cd ~/ && cd goinfre && mkdir backup && git clone $PRIVATE_GIT gcl$DATE; cd gcl$DATE;
		mv ~/backup_session_1337_$DATE.tar .
		echo "Compressing the backup...."
		xz -9 backup_session_1337_$DATE.tar
		echo "Compressing done" 
		git add backup_session_1337_$DATE.tar.xz && git commit -m "backup $DATE" && git push
		cd ~/ && cd goinfre && rm -rf backup
		#If you prefer using a dmg image to backup, just uncomment the line below
		#hdiutil create -fs HFS+ -srcfolder ~/.tmp/$BACKUPNAME -volname Backup_1337_$DATE backup_session_1337_$DATE.dmg
		sleep 1800s
done

