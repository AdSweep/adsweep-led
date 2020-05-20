#!/bin/bash

file='/etc/adsweep/isledon'

while read line; do
	ledon=$line
done < $file

# Get current led status
file='/etc/adsweep/led.status'

while read line; do
	status=$line
done < $file

if [ $ledon -eq 0 ] ;
then
	echo "ledOff"
else
	if [ $status == "ledOff" ] ; then
		echo "greenOn"
	else
		echo $status
	fi
fi
