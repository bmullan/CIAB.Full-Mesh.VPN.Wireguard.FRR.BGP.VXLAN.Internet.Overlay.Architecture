#!/bin/bash

sudo wg-quick up ciabmesh
sleep 4
sudo ip -6 addr add $(generate-ipv6-address fe80::) dev ciabmesh


