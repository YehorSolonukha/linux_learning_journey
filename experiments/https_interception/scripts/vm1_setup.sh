#!/bin/bash

# set up ip on internal interface 
sudo ip addr add 192.168.1.1/24 dev enp0s3

# set up default gateway to point to VM2
sudo ip route del default
sudo ip route add default via 192.168.1.2 dev enp0s3

# set up external dns server
NEW_DNS="8.8.8.8"
FILE="/etc/resolv.conf"

if grep -q "^nameserver" $FILE; then
	sudo sed -i "0,/^nameserver.*/s//nameserver $NEW_DNS/" "$FILE"
	echo "DNS entry updated to $NEW_DNS"
else
	sudo echo "nameserver $NEW_DNS" | sudo tee -a $FILE > /dev/null
fi
