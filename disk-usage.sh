#!/bin/bash

DISK_USAGE=$(df -hT | grep xfs)
DISK_THRESHOLD=3
MSG=""

while read -r line
do
USAGE=$(echo "$line" | awk '{print $6}' | cut -d "%" -f1)
PARTITION=$(echo "$line" | awk '{print $NF}')

if [ -n "$USAGE" ] && [ "$USAGE" -ge "$DISK_THRESHOLD" ]
then 
   MSG+="High disk usage on partition: $PARTITION Usage is $USAGE% \n"
fi
done <<< "$DISK_USAGE"

echo -e "$MSG"
