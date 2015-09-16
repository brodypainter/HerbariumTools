#!/bin/bash

# Utility for checking specimens in that were on loan

loanid="$(osascript -e 'tell app "System Events" to display dialog "Please enter loan identifier (ex. \"99-05\")" default answer ""')"
if [ $? -ne 0 ]; then
    # The user pressed Cancel
    exit 1 # exit with an error status
elif [ -z "$loanid" ]; then
    # The user left the project name blank
    osascript -e 'Tell application "System Events" to display alert "You must enter a loan identifier; cancelling..." as warning'
    exit 1 # exit with an error status
fi

# ssh to db.herb, login to mysql, run script, exit mysql, exit ssh

while true; do
	read -p "Scan a barcode" catNum
	echo $catNum
done