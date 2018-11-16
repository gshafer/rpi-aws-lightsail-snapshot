# rpi-aws-lightsail-snapshot
Automatically create and delete AWS Lightsail Snapshots

Using a Raspberry Pi running Ubuntu, this bash shell script run weekly by cron, will create a new Lightsail snapshot and delete the one from 2 weeks ago.

It will email you the output from the create and delete command after execution so you know that it was successfull.

Code will handle years that have 53 weeks in them.

AWS Lightsail CLI commands muct be installed on the RPI. Instructions here:

https://iotbytes.wordpress.com/aws-iot-cli-on-raspberry-pi/

Setup cron to run the shell script weekly on a Sunday.

Example (crontab -e command to edit cron):

5 1 * * 0 /path/to/file/aws.sh


