#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have sudo access to this script"
    exir 1
fi

dnf list installed mysql

if [ $? -ne 0 ]
then
    dnf install mysql -y
    if [ $? -ne 0 ]
    then 
        echo "mysql installation failed"
    else
        echo "installing mysql success"
    fi
else 
    echo "mysql is installed already"

fi

dnf list installed git

if [ $? -ne 0 ]
then
    dnf install git -y
    if [ $? -ne 0 ]
    then 
        echo " git installation is failed"
    else
        echo " installation of git success"
    fi
else
    echo "git is already installed"
fi
