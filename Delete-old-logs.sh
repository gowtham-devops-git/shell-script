#!/bin/bash 

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[3m"
N="\e[0m"

SOURCE_DIR="/home/ec2-user/app-logs"

LOGS_FOLDER="/var/log/shellscript-logs"
LOGFILE=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%s)

LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


VALIDATE() {
    if [$1 -ne 0]
    then
        echo -e "$2 ... $R failed $N"
        exit 1
    else
        echo -e "$2 ... $G success $N"

    fi

}

CHECK_ROOT() {
    if [$USERID -ne 0]
    then
        echo "$R ERROR:: you must have sudo access to execute this script $N"
        exit 1
    fi
}

echo "script started executing at $TIMESTAMP" &>>$LOG_FILE_NMAE

FILE_TO_DLT=$(find $SOURCE_DIR -name "*.log" -mtime +14)

echo "files to be deletd: $FILES_TO_DLT"

while read -r line filepath
do 
  echo "deleting file: $filepath" &>>$LOG_FILE_NAME
  rm -rf $filepath
  echo "deleted file: $filepath"

done <<< $FILES_TO_DLT