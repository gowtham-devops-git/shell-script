#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2

DAYS=${3:-14}

LOGS_FOLDER="/var/log/shellscript-logs"
LOGFILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%s)

LOG_FILE_NAME="$LOGS_FOLDER/$LOGFILE-$TIMESTAMP.log"

USAGE() {
    echo -e "$R USAGE $N backup <SOURCE_DIR> <DEST_DIR> <DAYS(OPTIONAL)>"


}

if [ $# -le 2 ]
then 
    USAGE
fi

if [ ! -d "$SOURCE_DIR" ]
then
    echo -e "$SORCE_DIR Does not exists"
    exit 1
fi

if [ ! -d "$DEST_DIR" ]
then
    echo -e "$DEST_DIR Does not exits"
    exit 1

fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)



if [ -n "$FILES" ]
then 
    echo "files are : $FILES"
    ZIP_FILE="$DEST_DIR/APP-LOGS-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip "$ZIP_FILE" -@
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "successsfully created the zip file"
        while read -r filepath
        do 
           echo "deleting file $filepath"
           rm -rf $filepath

        done <<< $FILES
    else
        echo -e "$R ERROR:: $N Failed to create zip file"
    fi
 else 
     echo " there are no files older"
fi


