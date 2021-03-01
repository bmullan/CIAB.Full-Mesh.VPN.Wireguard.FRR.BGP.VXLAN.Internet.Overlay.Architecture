#!/bin/bash

#
# Startup Script for FRR on Ubuntu
#
# Documentation for FRR:  http://docs.frrouting.org/en/latest/setup.html
#

dt=$(date '+%m/%d/%Y %H:%M:%S');

echo
echo "===={Starting FRR at}======"
echo
echo "$dt GMT"
echo
echo "==========================="
echo
sudo service frr start


