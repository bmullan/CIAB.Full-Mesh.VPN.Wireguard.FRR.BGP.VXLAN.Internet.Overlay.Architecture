#!/bin/bash

# Script to Restart Quagga BGP on a Node

dt=$(date '+%m/%d/%Y %H:%M:%S');

echo
echo "========================="
echo "Stopping Node BGP at..."
echo "$dt GMT"
echo "========================="
echo

sudo service zebra stop
sudo service bgpd stop

