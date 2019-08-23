#!/bin/bash
#
# Sample usage:
#   backup_script   /storage/rsnapshot/scripts/backup_mysql.sh "hostname"      ./mysqldumps/
#   or
#   backup_script   /storage/rsnapshot/scripts/backup_mysql.sh "hostname" "2222"      ./mysqldumps/
#
client_host="$1"
client_user="root"

ssh_port="22"
if [ ! -z "$2" ]; then
        ssh_port="$2"
fi
client_ssh_uri="${client_user}@${client_host} -p ${ssh_port}"

# global vars
DATE=`date +%F`
MYSQLDUMP="/usr/bin/mysqldump"
MYSQL="/usr/bin/mysql"
GZIP="/bin/gzip"

db_list=$(ssh ${client_ssh_uri} "$MYSQL -B -e 'show databases' | sed -e 1d | grep -E -v '^(information_schema|performance_schema)$'")

for db in $db_list; do
        ssh ${client_ssh_uri} "$MYSQLDUMP -uroot --opt --skip-lock-tables --single-transaction --routines $db | $GZIP" > $db.$DATE.sql.gz
done

