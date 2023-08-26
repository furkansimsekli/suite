#!/bin/bash

set -e

# Target network with a subnet mask
TARGET_NET="192.168.1.0/24"

# Raspberry Pi's MAC address, you can change it.
MAC_ADDR="B8:27:EB:A3:BF:CD"

RESULT=$(sudo nmap -sn "$TARGET_NET" | grep -B 2 "$MAC_ADDR" || true)

if [ -n "$RESULT" ]; then
    echo -e "\e[32m$RESULT\e[0m"
else
    echo -e "\e[31mCouldn't find your raspberry pi!\e[0m"
fi

