#!/bin/bash
#~
#~USAGE:
#~
#~  PROG <current|daily|weekly|monthly> [bucket]
#~

PERIOD="${1:-current}"
BUCKET="${2:-dci-db-backups-prod}"
BASEDIR="/tmp"

function usage(){
    grep "^#~" $0 | sed -e "s/#~//" | sed -e "s/PROG/$(basename $0)/"
}

function do_snap(){
    # this should create the snapshot with pg_dump
    TS="$1"
    /usr/bin/pg_dump -d dci -Fc --file "${BASEDIR}/db_dump-${TS}"
}

NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "Snapshotting $PERIOD to $BUCKET"

echo $(date -Iseconds) "  >>>> Starting snapshot creation"
do_snap $NOW || (echo "Snapshot creation failed"; exit 2)
echo $(date -Iseconds) "  <<<< Finished snapshot"
echo $(date -Iseconds) "  >>>> Sending to S3"
/usr/local/bin/aws s3 cp "$BASEDIR/db_dump-$NOW" s3://$BUCKET/$PERIOD/db_dump-$NOW --only-show-errors && rm -fv "${BASEDIR}/db_dump-$NOW" || (echo "Upload failed"; exit 3)
echo $(date -Iseconds) "  <<<< Sent"
/usr/local/bin/aws s3 ls s3://$BUCKET/$PERIOD/db_dump-$NOW
