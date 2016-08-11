#!/bin/sh
LOGGEDINUSER=$(ls -l /dev/console | awk '{print $3}')
echo "LOGGEDINUSER is: $LOGGEDINUSER"
PW_EXPIRE=15                    # 90 days password expiration (tested with 1 and 2, troubleshoot notification of days remaining)
MIN_LENGTH=7                    # at least 7 chars for password
MIN_NUMERIC=1                   # at least 1 number in password
MIN_SPECIAL_CHAR=0              # at least one special character in password
PW_HISTORY=4                    # remember last 4 passwords
exemptAccount1="admin"          #Exempt account
echo "<dict>
 <key>policyCategoryPasswordChange</key>
  <array>
   <dict>
    <key>policyContent</key>
     <string>policyAttributeCurrentTime &gt; policyAttributeLastPasswordChangeTime + (policyAttributeExpiresEveryNDays * 24 * 60 * 60)</string>
    <key>policyIdentifier</key>
     <string>Change every $PW_EXPIRE days</string>
    <key>policyParameters</key>
    <dict>
     <key>policyAttributeExpiresEveryNDays</key>
      <integer>$PW_EXPIRE</integer>
    </dict>
   </dict>
  </array>


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

  pwpolicy -u $LOGGEDINUSER -clearaccountpolicies
  pwpolicy -u $LOGGEDINUSER -setaccountpolicies /private/var/tmp/pwpolicy.plist

#delete staged pwploicy.plist
rm -f /private/var/tmp/pwpolicy.plist

exit 0
