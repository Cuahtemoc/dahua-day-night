#!/bin/bash
# day-mode.sh

# Wait until 30 minutes past sunrise to change camera modes
/usr/local/bin/sunwait wait offset 00:30:00 rise xx.xxxS xxx.xxxxE
echo "Switching to day mode" | logger

# Send requests in parallel with logging for success/failure
{ http -A digest -a username:password GET "http://cameraipaddress/cgi-bin/configManager.cgi?action=setConfig&VideoInMode[0].Config[0]=0" && echo "Camera .xx: success" | logger || echo "Camera .xx: failure" | logger; } &

# Wait for all background jobs to finish
wait
echo "Day mode switch completed" | logger
