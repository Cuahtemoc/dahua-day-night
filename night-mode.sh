#!/bin/bash
# night-mode.sh

# wait until civil sunset to change cameras to night mode
/usr/local/bin/sunwait wait civil set xx.xxxS xxx.xxxxE
echo "Switching to night mode" | logger

# Send requests in parallel with logging for success/failure
{ http -A digest -a username:password GET "http://cameraipaddress/cgi-bin/configManager.cgi?action=setConfig&VideoInMode[0].Config[0]=1" && echo "Camera .xx: success" | logger || echo "Camera .xx: failure" | logger; } &

# Wait for all background jobs to finish
wait
echo "Night mode switch completed" | logger
