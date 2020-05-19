#!/bin/bash

# Create or update led program symlink
ln -sf /home/pi/adsweep-led/getStatus.sh /bin/adsweep-led

# Update or move service units to the correct folder
cp /home/pi/adsweep-led/AdSweepLedPy.service /etc/systemd/system/
cp /home/pi/adsweep-led/AdSweepLedSh.service /etc/systemd/system/

# Refresh service unit
systemctl daemon-reload