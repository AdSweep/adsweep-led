#!/bin/bash

# Get current led status
file='/home/pi/adsweep-led/led.status'

while read line; do
	echo $line

done < $file
