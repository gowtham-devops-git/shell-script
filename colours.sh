#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"



VALIDATE(){
    if [$1 -ne 0]
    then
        echo "$2 ... $R failed"
        exit 1
    else
        echo "$2 ...  $G  sucess"
    fi

}

if [$USERID -ne 0]
then
    echo "ERROR:: You must have sudo access to run this script"
    exit 1
else
    echo "you are a sudo user"

fi

dnf list installed mysql

if [$? -ne 0]
then
    dnf install mysql -y
    VALIDATE $? "Installing mysql"
else
    echo "mysql is already .. $Y installed"
fi