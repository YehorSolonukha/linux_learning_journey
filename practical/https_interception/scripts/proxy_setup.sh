#!/bin/bash

# set up ip on internal interface
sudo ip addr add 192.168.1.2/24 dev enp0s3

# enable routing
sudo sysctl -w net.ipv4.ip_forward=1

# setup NAT so VM1 can reach the internet
sudo iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE

# redirect http and https traffic to mitmproxy on port 8080
sudo iptables -t nat -A PREROUTING -i enp0s3 -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -t nat -A PREROUTING -i enp0s3 -p tcp --dport 443 -j REDIRECT --to-port 8080

