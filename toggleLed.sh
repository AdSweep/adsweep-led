#!/bin/bash

DATA=$(head -n 1 /etc/adsweep/isledon)
ZERO=0
ONE=1

if [ $DATA == $ONE ]; then
	echo "0" > /etc/adsweep/isledon
elif [ $DATA == $ZERO ]; then
	echo "1" > /etc/adsweep/isledon
fi
