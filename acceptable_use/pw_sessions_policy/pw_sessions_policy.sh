#!/bin/bash
pwpolicy -setpolicy "minChar=7 usingHistory=4 requiresAlpha=1 requiresNumeric=1 canModifyPasswordforSelf=1 newPasswordRequired=0 maxMinutesUntilChangePassword=2" # password policy: change every 90 (129600) testing with 5, 7 char or more, remembers and rejects last 4 passwords, 1 alpha and 1 numeric minimums
exit 0


#-getglobalpolicy before -setglobalpolicy maxMinutesUntilChangePassword is being a pain
