#!/bin/bash

# Script to Restart Quagga BGP on a Node

dt=$(date '+%m/%d/%Y %H:%M:%S');

echo
echo "========================="
echo "Restarting Node BGP at..."
echo "$dt GMT"
echo "========================="
echo

sudo service zebra stop
sudo service bgpd stop
sudo service zebra start
sudo service bgpd start

