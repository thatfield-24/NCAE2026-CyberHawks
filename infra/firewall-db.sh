#!/bin/bash

iptables -F

# deny outgoing/incoming traffic on default
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# allow established connections
iptables -A INPUT -m conntrack --cstate ESTABLISHED, RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --cstate ESTABLISHED, RELATED -j ACCEPT

# ping
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT

# allows scoring user to connect to sql
iptables -A INPUT -p tcp -s [scoring ip address] --dport 5432 -j ACCEPT
# iptables -A OUTPUT -p tcp -s [scoring ip address] --dport 5432 -j ACCEPT

# templates in case i need them
# iptables -A OUTPUT -p [tcp/udp] --dport [port] -j ACCEPT

