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

case $PERIOD in
    current)
	EXPIRE="1 week"
	;;
    daily)
        EXPIRE="2 week"
        ;;
    weekly)
        EXPIRE="6 week"
        ;;
    monthly)
        EXPIRE="3 month"
        ;;
    *)
        usage
        exit 1;
        ;;
esac

NOW=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
THEN=$(date -u +"%Y-%m-%dT%H:%M:%SZ" --date="today + $EXPIRE")

echo "Snapshotting $PERIOD to $BUCKET (will expire in $EXPIRE : $NOW -> $THEN)"

echo $(date -Iseconds) "  >>>> Starting snapshot creation"
do_snap $NOW || (echo "Snapshot creation failed"; exit 2)
echo $(date -Iseconds) "  <<<< Finished snapshot"
echo $(date -Iseconds) "  >>>> Sending to S3"
/usr/local/bin/aws s3 cp "$BASEDIR/db_dump-$NOW" s3://$BUCKET/$PERIOD/db_dump-$NOW --expires="$THEN" --only-show-errors && rm -fv "${BASEDIR}/db_dump-$NOW" || (echo "Upload failed"; exit 3)
echo $(date -Iseconds) "  <<<< Sent"
/usr/local/bin/aws s3 ls s3://$BUCKET/$PERIOD/db_dump-$NOW
