#!/bin/sh

#turn on/off Touch pad
DEVICE="$(xinput | grep TouchPad | sed -n 's/.*id=\([0-9]\+\).*/\1/p')"
STATE=`xinput list-props $DEVICE |grep 'Device Enabled'|awk '{print $4}'`

if [ $STATE -eq 1 ]; then
	xinput set-prop "$DEVICE" "Device Enabled" 0
else
	xinput set-prop "$DEVICE" "Device Enabled" 1
fi