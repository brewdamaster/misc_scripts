#!/bin/sh
user=$(id -F)
SN=$(system_profiler SPHardwareDataType | awk '/Serial/ {print $4}')
time=$(date)
echo "Please enter your first and last name"
read uname
sudo pwpolicy -clearaccountpolicies
sudo pwpolicy -setglobalpolicy "minChars=8 requiresNumeric=1"
sudo pwpolicy -u $user -setpolicy "newPasswordRequired=1"
sudo postfix stop
sudo mkfifo /var/spool/postfix/public/pickup
sudo postfix start
echo "Password policy applied to $SN on $time" | mail -s “$uname" f4ym3y4c@robot.zapier.com
