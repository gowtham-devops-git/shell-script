#!/bin/bash

NUMBER1=$1
NUMBER2=$2

TIMESTAMP=$(date)

echo "script started at : $TIMESTAMP"

SUM=$(($NUMBER1+$NUMBER2))

echo " the sum of $NUBER1 and $NUMBER2 is $SUM