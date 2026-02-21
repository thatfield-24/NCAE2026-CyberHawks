#!/bin/bash
# Used to kill services that are running on the machine, and prevent them from starting again.
# Usage: sudo ./kill_service.sh <service1> <service2> For example: sudo ./kill_service.sh cron sshd
for var in "$@"
do
	systemctl stop "$var.service" "$var.socket" 
	systemctl disable "$var.service" "$var.socket"
	systemctl mask "$var.service" "$var.socket"
	file=$(systemctl show -P FragmentPath "$var")
	if [ -n "$file" ]; then
		mv "$file" "$file.bak"
		echo "$file" >> killed_services
	else
		echo "$var" >> killed_services
	fi
done
systemctl daemon-reload