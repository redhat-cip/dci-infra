#!/bin/sh

source /etc/dci_pgbackup.conf

#TEMP_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1).txt
TEMP_NAME=expected_results_api.txt

function send_mail() {
    MESSAGE=$1
    SUBJECT="[ALERT][DCI] Something went wrong with the restore process"
}

# Retrieve the last record of a given table and verify
# that the record set match as expected
for key in {job,user,remoteci,team}; do
    nbr=$(dcictl --format json $key-list | jq "[.${key}s][] | length")
    echo "${key}s,$nbr" >> /tmp/$TEMP_NAME
done

diff /tmp/$TEMP_NAME $OUTPUT_DIR/expected_results.txt
if [[ "$?" -ne 0 ]]; then
    # If backup doesn't match send an email to let team
    # now something went wrong
    send_mail "The dump restored is incorrect"
fi
