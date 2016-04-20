#!/bin/sh

source /opt/rh/rh-postgresql94/enable
source /etc/dci_pgbackup.conf

function send_mail() {
    MESSAGE=$1
    SUBJECT="[ALERT][DCI] Something went wrong with the restore process"
}

# Start the httpd daemon if necessary
sudo systemctl start httpd || true

# Retrieve the last record of a given table and verify
# that the record set match as expected
for key in {job,user,remoteci,team}; do
    nbr=$(dcictl --dci-login $DCI_LOGIN --dci-password $DCI_PASSWORD --dci-cs-url $DCI_CS_URL --format json $key-list | jq "[.${key}s][] | length")
    echo "${key}s,$nbr" >> /tmp/expected_results_api.txt
done

diff /tmp/expected_results_api.txt $OUTPUT_DIR/expected_results.txt
if [[ "$?" -ne 0 ]]; then
    # If backup doesn't match send an email to let team
    # now something went wrong
    send_mail "The dump restored is incorrect"
fi
