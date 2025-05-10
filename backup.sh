#!/bin/bash
backup_directory="/var/db"    #edit directory  to be backed up  here
backup_destination="/var/backup" #edit archived backup file destination here
backup_date=$(date)
backup_filename="backup_$backup_date.tar.gz"
retain_time=7
mkdir -p /var/log/backup
log_file="/var/log/backup/backup.log"
touch $log_file

function fail_alert(){
    user=$(whoami)
    mail -s "$1" "$user" <<< "$2"
}
#user perviliges
if [ "$(whoami)" != "root" ]; then
    echo "Please run this script as root."
    exit 1
fi



if [ -f "$log_file.5" ]; then #hitting the limit of log rotation 
    rm -rf "$log_file.1"  
    for ((i=2; i<=5;i++))
    do
        mv "$log_file.$i" "$log_file.$((i - 1))"
    done
    
    

fi

#log rotation
for ((i=1; i<=5; i++))
do 

    if [ ! -f "$log_file.$i" ]; then
        mv $log_file "$log_file.$i"
        break
    fi
done





#logging the start date
echo "$(date) : backup started" >> $log_file


#checking backup directory
if  ! ls $backup_directory > "/dev/null";  then  
    echo "The specified directory is not accessible - Please verify the location and permissions" 
    echo "$(date) : backup failed with the reason : The specified directory is not accessible - Please verify the location and permissions" >> "$log_file"
    fail_alert  "backup failed: directory issue" "$(date) : backup failed with the reason : The specified directory is not accessible - Please verify the location and permissions" 

    exit 2
fi


#checking backup destination

if ! ls $backup_destination > "/dev/null" ; then
    echo "The archive destination directory is not accessible - Please verify the location and permissions"
    echo "$(date) : backup failed with the reason : The archive destination directory is not accessible - Please verify the location and permissions" >> "$log_file"

    fail_alert  "backup failed: directory issue" "$(date) : backup failed with the reason : The archive destination directory is not accessible - Please verify the location and permissions" 
    exit 2
fi


#create backup

if ! tar -czf "$backup_destination/$backup_filename" "$backup_directory"; then  
    echo "$(date) : backup failed with the reason : can't create archive" >> "$log_file"

    fail_alert  "backup failed: Archiving issue" "$(date) : backup failed with the reason : can't create archive"
    
  
    exit 2
fi

echo "$(date) : backup archive created successfully" >> "$log_file"

# delete files older than a certian amount of time 


if ! find $backup_destination -type f -mtime +$retain_time -delete; then  
    echo "$(date) : backup failed with the reason : can't remove Old backups" >> "$log_file"
    fail_alert  "backup failed: backup cleanup"  "$(date) : backup failed with the reason : can't remove Old backups"

  
    exit 2
fi

echo "$(date) : Old backups removed successfully" >> "$log_file"

echo "Backup Completed Successfully!"



