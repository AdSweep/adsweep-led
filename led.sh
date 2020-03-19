#!/bin/bash

POLLINGTIMEBEFORE=1
POLLINGTIMEAFTER=60

PHSTATUSDNS="DNS service is running"
PHSTATUSBLOCKING="Pi-hole blocking is Enabled"

# Check Pi-Hole status
function phStatus()
{
	PHSTATUS=$(pihole status)
	if [[ $PHSTATUS == *$PHSTATUSGOOD* && $PHSTATUS == *$PHSTATUSBLOCKING* ]];
	then
		echo 1
	else
		echo 0
	fi
}

# Get current led status
function readLed()
{
	file='led.status'
	while read line; do
	echo $line
	done < $file
}

while [ 1 ]
do
	phs=$(phStatus)
	if [ phs ] ;
	then
		echo Pi Hole status is OK
		echo $(python /home/pi/adsweep-led/led.py greenOn)
	else
		echo Pi Hole status is NOT OK
		echo $(python /home/pi/adsweep-led/led.py redOn)
	fi
done
