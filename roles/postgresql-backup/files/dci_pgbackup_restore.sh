#!/bin/sh

source /etc/dci_pgbackup.conf

function send_mail() {
    MESSAGE=$1
    SUBJECT="[ALERT][DCI] Something went wrong with the restore process"
}

#TODO remove CREATE USER / ALTER USER postgres
sed -i 's/CREATE ROLE postgres;//g' $OUTPUT_DIR/$BACKUP_GLOBALS
sed -i 's/ALTER ROLE postgres.*//g' $OUTPUT_DIR/$BACKUP_GLOBALS

# Remove the previous version of the database if any
#
dropdb -U postgres $PG_DATABASE || true
dropuser -U postgres $PG_USER || true

# Load the current latest version
#
createdb -U postgres $PG_DATABASE
psql -U postgres -f $OUTPUT_DIR/$BACKUP_GLOBALS

pg_restore -U $PG_USER -d $PG_DATABASE $OUTPUT_DIR/$BACKUP_FILENAME
if [[ "$?" -ne 0 ]]; then
    send_mail "The pg_restore command failed"
fi
