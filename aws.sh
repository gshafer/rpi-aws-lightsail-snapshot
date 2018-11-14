#!/bin/bash

#Set email address
email="YOUR EMAIL ADDRESS"

# How many weeks of snapshots to keep
delete=2

# Name the new weekly snapshot the week number
week=$(date +%V)
#echo $week

#Name the snapshot to delete
twoweek=`expr $week - $delete`
#echo $twoweek

#Weeks in the year
#adjust for year 2022
year=$(date +%Y)
pyear=2022
#echo $year
if [ $year -eq  $pyear ]
then
	numweeks=53
else
	numweeks=52
fi

#Adjust delete name for first 2 weeks of the year
if [ $week -eq 1 ]
then
twoweek=`expr $numweeks - 1`
fi

if [ $week -eq 2 ]
then
twoweek=$numweeks
fi

#echo $twoweek

#Create new snapshot

/usr/local/bin/aws lightsail create-instance-snapshot --instance-name YOUR-INSTANCE-NAME --instance-snapshot-name $week 2>&1 | mail -s "Create Snapshot for AWS" $email

#Delete older snapshot

/usr/local/bin/aws lightsail delete-instance-snapshot --instance-snapshot-name $twoweek 2>&1 | mail -s "Delete Snapshot for AWS" $email
