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

function writeLed()
{
	echo $1 > led.status
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
		echo "Pi Hole status is OK"
		writeLed "greenOn"
	else
		echo "Pi Hole status is NOT OK"
		writeLed "redOn"
	fi
	sleep 1
done
