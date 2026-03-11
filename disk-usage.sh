#!/bin/bash

USAGE=$(dh -hT | grep xfs)
DISK_THRESHOLD=3

MSG=""

while read -r line
do
  USAGE=$(echo $line | awk -F " " '{print $6}' | cut -d "%" -f1)
  PARTITION=$(echo $line | awk -F " " '{print $N}')

  if [ $USAGE -gee $DISK_THRESHOLD ]
  then 
      MSG+="High disk usage on partition: $PARTITION Usage is $USAGE \n"
  fi
done <<< $DISK_USAGE

