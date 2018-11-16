#!/bin/bash

#Set email address
email="george@shafer.ca"

#Set Day to do backps, Sunday is 0
bud=0 

#Determine year
year=$(date +%Y)

#Determine last year
lyear=`expr $year - 1` 
#echo $lyear

# How many weeks of snapshots to keep
delete=2

# Name the new weekly snapshot the week number
week=$(date +%V)
#echo $week

#Name the snapshot to delete
twoweek=`expr $week - $delete`
#echo $twoweek

#Weeks in the year-  will be corrected below for years with 53 weeks
numweeks=52

#Set week number for testing
#week=1

#Adjust delete name for first 2 weeks of the year
if [ $week -eq 1 ]
then
lastsunday=$(cal 12 $lyear | awk '/^ *[0-9]/ { d=$1 } END { print d }')
#echo $lastsunday
numweeks=$(date -d "$lyear-12-$lastsunday" +%V)
#echo $numweeks
twoweeks=`expr $numweeks - 1`
#echo $twoweeks
fi

if [ $week -eq 2 ]
then
lastsunday=$(cal 12 $lyear | awk '/^ *[0-9]/ { d=$1 } END { print d }')
#echo $lastsunday
numweeks=$(date -d "$lyear-12-$lastsunday" +%V)
#echo $numweeks
twoweeks=$numweeks
#echo $twoweeks
fi

#echo $twoweeks

#Create new snapshot

/usr/local/bin/aws lightsail create-instance-snapshot --instance-name Shafer-2GB-Ohio-1-Server6 --instance-snapshot-name $week 2>&1 | mail -s "Create Snapshot for AWS" $email

#Delete older snapshot

/usr/local/bin/aws lightsail delete-instance-snapshot --instance-snapshot-name $twoweek 2>&1 | mail -s "Delete Snapshot for AWS" $email
