#! /bin/bash

## FIXED Variable
export TODAY=$(date '+%d-%m-%Y')
export LOG=$(date '+%d-%m-%Y-%H:%M')

## USER Variables
export BACKUP=backup
export MNT=/mnt/HDDData
export HOMEDIR=/home/leschtz
export LOGDIR=$HOMEDIR/log/backup/$LOG.txt

# redirecting STDOUT and STDERR to $LOG
exec > $LOGDIR
exec 2>&1

start_Backup() {
  printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: Starting backup.\n"
  rsync -av --progress --delete $HOMEDIR $BACKUP/$TODAY/
  if [ $? -ne 0 ]; then
    printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: An error occured during backuping\n"
    printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: FAIL.\n"
  else
    printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: Finished backup.\n"
    printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: SUCCESS.\n"
  fi
}

mountpoint -q "$MNT"
if [ $? -ne 0 ]; then
  ## CARE: User needs to have mounting rights, otherwise it won't work
  mount "$MNT"
  if [ $? -eq 0 ]; then
    printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: Mounted successfully.\n"
  else
    printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: Something went wrong with the mount...\n"
    printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: FAIL."
    exit 1
  fi
else
  printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: $MNT already mounted.\n"
fi

cd "$MNT"
mkdir $BACKUP/$TODAY
start_Backup
printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: Copying logfile from $LOGDIR to $MNT/$BACKUP/$TODAY.\n"
cp $LOGDIR $BACKUP/$TODAY
printf "[$(date '+%d-%m-%Y; %H:%M:%S')]: FINISHED."
exit 0
