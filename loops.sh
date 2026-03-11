#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1)
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

CHECK_ROOT

for package in $@
do 
    dnf list installed $package &>>LOG_FILE_NAME
    if [$? -ne 0]
    then
        dnf install $package -y &>>LOG_FILE_NAME
        VALIDATE $? "INSTALLING $pacakge"
    else
        echo -e "$package is already $Y .. installed $N"
    fi
done 

