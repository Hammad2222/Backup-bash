The backup script is inteded to perform a compressed backup of your specified folder

To start using the script Please edit the following variables

backup_directory="/var/db"    #edit directory  to be backed up  here
backup_destination="/var/backup" #edit archived backup file destination here

You can also set the amount of backup retention days by setting the following var 

retain_time=7 #default is 7 days


####################################

The script also provides log rotation to conserve space and allows maximum of 5  backup logs in addition to the current latest log
Log location can be also edited and assigned a new location by updating the following lines: 

mkdir -p /var/log/backup
log_file="/var/log/backup/backup.log"


+++++++++++++++++++++++++

How to Run the file? 
Make sure the file is excutable by running: chmod u+x ./backup.sh
or run it from the termainal using: bash ./backup.sh
