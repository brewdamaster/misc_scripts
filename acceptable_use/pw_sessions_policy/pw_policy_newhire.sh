#!/bin/sh
LOGGEDINUSER=$(ls -l /dev/console | awk '{print $3}')
echo "LOGGEDINUSER is: $LOGGEDINUSER"
MIN_LENGTH=8                    # at least 8 chars for password
MIN_NUMERIC=1                   # at least 1 number in password
PW_HISTORY=4                    # remember last 4 passwords
exemptAccount1="admin"          #Exempt admin account1
echo "<dict>
  <key>policyCategoryPasswordContent</key>
 <array>
  <dict>
   <key>policyContent</key>
    <string>policyAttributePassword matches '.{$MIN_LENGTH,}+'</string>
   <key>policyIdentifier</key>
    <string>Has at least $MIN_LENGTH characters</string>
   <key>policyParameters</key>
   <dict>
    <key>minimumLength</key>
     <integer>$MIN_LENGTH</integer>
   </dict>
  </dict>

  <dict>
   <key>policyContent</key>
    <string>policyAttributePassword matches '(.*[0-9].*){$MIN_NUMERIC,}+'</string>
   <key>policyIdentifier</key>
    <string>Has a number</string>
   <key>policyParameters</key>
   <dict>
   <key>minimumNumericCharacters</key>
    <integer>$MIN_NUMERIC</integer>
   </dict>
  </dict>

  <dict>
   <key>policyContent</key>
    <string>none policyAttributePasswordHashes in policyAttributePasswordHistory</string>
   <key>policyIdentifier</key>
    <string>Does not match any of last $PW_HISTORY passwords</string>
   <key>policyParameters</key>
   <dict>
    <key>policyAttributePasswordHistoryDepth</key>
     <integer>$PW_HISTORY</integer>
   </dict>
  </dict>
 </array>
</dict>" > /private/var/tmp/pwpolicy.plist

  chmod 644 /private/var/tmp/pwpolicy.plist

  pwpolicy -u signpost -clearaccountpolicies
  pwpolicy -u signpost -setaccountpolicies /private/var/tmp/pwpolicy.plist
  pwpolicy -u signpost -setpolicy "newPasswordRequired=1"

#delete staged pwploicy.plist
rm -f /private/var/tmp/pwpolicy.plist

exit 0
