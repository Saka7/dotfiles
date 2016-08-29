#!/bin/bash

status=$(synclient -l | grep TouchpadOff | awk '{print $3}')

if [ $status -eq 0 ];then
	status=0
else
	status=1
fi

echo $status
xinput set-prop 14 "Device Enabled"  $status

