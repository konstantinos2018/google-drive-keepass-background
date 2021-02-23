#!/usr/bin/bash

#trap "echo Unmounting;unmountgdrive;exit 0" SIGINT

if [[ "$1" != "-n" ]]; then
    $0 -n & disown
    exit $?
fi

# Initiate and mount gdrive
google-drive-ocamlfuse ~/google-drive
#echo "Google Drive started succesfully..."

# Start keepass2
keepass2 > /dev/null 2>&1 &
#echo "KeePass started succesfully..."

# save PID to variable
keepasspid=$!

while true > /dev/null 2>&1; do
    if ! kill -0 $keepasspid > /dev/null 2>&1
        then
            #echo "KeePass was found to be closed..."
            #echo "Unmounting Google Drive..."
            fusermount -u  ~/google-drive
            #kill 13838
            #exit 0
            #echo "before break"
            break
            #echo "after break"
    fi
    #echo "after if"
    sleep 3
done

exit 0
