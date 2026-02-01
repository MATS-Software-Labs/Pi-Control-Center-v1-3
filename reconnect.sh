#!/bin/bash
ping -c 1 8.8.8.8 > /dev/null
if [ $? != 0 ]; then
    echo "Internet weg! Starte WLAN neu..."
    nmcli device disconnect wlan0
    sleep 5
    nmcli device connect wlan0
fi
