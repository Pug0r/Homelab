#!/usr/bin/bash
#
# Checks whether anybody's phone is present at home and if it's between 8:30-23:30 then sets QBittorrent speed limits on.

convertToEpochTime() {
    local time=$1
    echo $(date -d "1970-01-01 $time" +%s)
}

source ../.env

nightStart="23:30"
nightEnd="8:30"

currentTime=$(date +'%H:%M')
currentTimeEpoch=$(convertToEpochTime "$currentTime")
nightStartEpoch=$(convertToEpochTime "$nightStart")
nightEndEpoch=$(convertToEpochTime "$nightEnd")

phoneFound=1

if [ $phoneFound -ne 0 ]; then
	sudo arp-scan --localnet | grep -q "$PHONE_MAC_A"
        phoneFound=$?
fi

if [ $phoneFound -ne 0 ]; then
	nmap -sn $MAIN_NETWORK_RANGE | grep -q "$PHONE_MAC_A"
	phoneFound=$?
fi

if [ $phoneFound -ne 0 ]; then
	sudo arp-scan --localnet | grep -q "$PHONE_MAC_J"
	phoneFound=$?
fi

if [ $phoneFound -ne 0 ]; then
	nmap -sn $MAIN_NETWORK_RANGE | grep -q "$PHONE_MAC_J"
	phoneFound=$?
fi

if [[ ($phoneFound -eq 0) && ($currentTimeEpoch -ge $nightEndEpoch) && ($currentTimeEpoch -le $nightStartEpoch) ]]; then
    python3 set_qb_limit.py 1
    echo "Limits set."
else
    python3 set_qb_limit.py 0
    echo "Limits lifted."
fi

