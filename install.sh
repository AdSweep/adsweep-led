#!/bin/bash

# Create or update led program symlink.
ln -sf /etc/adsweep/getStatus.sh /bin/adsweep-led
ln -sf /etc/adsweep/toggleLed.sh /bin/adsweep-toggle-led

# Update or move service units to the correct folder
cp /etc/adsweep/AdSweepLedPy.service /etc/systemd/system/
cp /etc/adsweep/AdSweepLedSh.service /etc/systemd/system/

# Refresh service unit
#systemctl daemon-reload
