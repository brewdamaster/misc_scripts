#!/bin/sh
user=$(id -F)
sudo pwpolicy -clearaccountpolicies
sudo pwpolicy -setglobalpolicy "minChars=8 requiresNumeric=1"
sudo pwpolicy -u $user -setpolicy "newPasswordRequired=1"
