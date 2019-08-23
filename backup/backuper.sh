#!/bin/bash
DOCKROOT="/var/www/digitizer"
BACKUP="/var/log/backup"
CARRENT_BACKUP="/var/log/backup/backup_$(date +%d%m%y)"
mkdir $CARRENT_BACKUP
tar -cvf $CARRENT_BACKUP/dockroot.tar.gz $DOCKROOT
mysqldump --opt ias1 > $CARRENT_BACKUP/ias.gz
find $CARRENT_BACKUP -mtime +10 -type d | xargs rm -f -r

#ls -l /var/log/backup

