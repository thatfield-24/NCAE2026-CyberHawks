#!/bin/bash
# Simple script to check for open ports, established connections, and processes open by other users. 
# Usage: sudo ./networkAudit.sh
# Run this script before running kill_service.sh to see what services are running and what ports are open. After running kill_service.sh, run this script again to confirm.
echo "--- Listening Ports and Processes ---"
# -l (listening) -t (tcp) -u (udp) -p (program name) -n (numeric addresses)
ss -tunpl | grep LISTEN

echo -e "\n--- Established/Active Connections ---"
ss -tunpa | grep ESTAB

echo -e "\n--- Current Sessions (WHAT=PID)---"
w -p

echo -e "\n--- Note Anything Suspicious for Reporting ---"
