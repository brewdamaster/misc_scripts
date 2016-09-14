#!/bin/sh
sudo rm -f /Users/Signpost/Library/Keychains/login.keychain
sudo rm -rf ~/Library/Keychains
pwpolicy -u signpost -clearaccountpolicies
pwpolicy -a admin -setglobalpolicy "minChars=8 usingHistory=4 requiresNumeric=1"
pwpolicy -u signpost -setpolicy "newPasswordRequired=1"
