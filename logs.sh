#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"

LOGS_FOLDER=/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." f1)
TIMESTAMP=$(date +%Y-%m-%D-%H-%M-%S)
LOGFILE_NAME="$LOGS_FOLDER/$LOGFILE-$TIMESTAMP.log"



VALIDATE(){
    if [$1 -ne 0]
    then
        echo "$2 ... $R failed $N"
        exit 1
    else
        echo "$2 ...  $G  sucess $N"
    fi

}

if [$USERID -ne 0]
then
    echo "ERROR:: You must have sudo access to run this script"
    exit 1
else
    echo "you are a sudo user"

fi

dnf list installed mysql &>>$LOGFILE_NAME

if [$? -ne 0]
then
    dnf install mysql -y   &>>$LOGFILE_NAME
    VALIDATE $? "Installing mysql"
else
    echo "mysql is already .. $Y installed $N"
fi

dnf list installed mysql &>>$LOGFILE_NAME

if [$? -ne 0]
then
    dnf install git -y   &>>$LOGFILE_NAME
    VALIDATE $? "Installing mysql"
else
    echo "git is already .. $Y installed $N"
fi