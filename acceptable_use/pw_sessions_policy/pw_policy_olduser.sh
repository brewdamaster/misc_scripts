#!/bin/bash
pwpolicy -clearaccountpolicies
pwpolicy -setglobalpolicy "minChars=8 requiresNumeric=1"
