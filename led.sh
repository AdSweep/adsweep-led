#!/bin/bash

POLLINGTIMEBEFORE=1
POLLINGTIMEAFTER=60

PHSTATUSDNS="DNS service is running"
PHSTATUSBLOCKING="Pi-hole blocking is Enabled"

# Check Pi-Hole status
function phStatus()
{
	PHSTATUS=$(pihole status)
	if [[ $PHSTATUS == *$PHSTATUSDNS* && $PHSTATUS == *$PHSTATUSBLOCKING* ]];
	then
		echo 1
	else
		echo 0
	fi
}

function writeLed()
{
	echo $1 > led.status
}

# Get current led status
function readFile()
{
	file=/etc/adsweep/isledon
	while read line; do
	echo $line
	done < $file
}

while [ 1 ]
do
	ledon=$(readFile)
	echo $ledon
	if [ $ledon -eq 1 ];
	then
		phs=$(phStatus)
		if [ $phs -eq 1 ] ;
		then
			echo "AdSweep status is OK"
			writeLed "greenOn"
		else
			echo "AdSweep status is NOT OK"
			writeLed "redOn"
		fi
	else
		echo "Led is OFF"
		writeLed "ledOff"
	fi
	sleep 1
done
