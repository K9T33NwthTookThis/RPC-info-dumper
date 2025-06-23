#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   printf "This script must be run as root"
   exit 1
fi

printf "version info:" > /tmp/rpc-dump.txt
cat /proc/version >> /tmp/rpc-dump.txt

printf "\n journalctl:" >> /tmp/rpc-dump.txt
journalctl -n 50 --no-pager >> /tmp/rpc-dump.txt

printf "\n dmesg:" >> /tmp/rpc-dump.txt
dmesg -H | tail -50 >> /tmp/rpc-dump.txt

printf "\n storage:" >> /tmp/rpc-dump.txt
df -h >> /tmp/rpc-dump.txt

printf "\n cpu info:" >> /tmp/rpc-dump.txt
lscpu >> /tmp/rpc-dump.txt

printf "\n pci:" >> /tmp/rpc-dump.txt
lspci >> /tmp/rpc-dump.txt

printf "\n uptime:" >> /tmp/rpc-dump.txt
uptime >> /tmp/rpc-dump.txt

# Remove all user names on system
getent passwd | while IFS=: read -r name password uid gid gecos home shell; do
  cat /tmp/rpc-dump.txt | awk -v user="$name" '{gsub(user, "[REDACTED]"); print}' | tee /tmp/rpc-dump.txt &>/dev/null
done

cat /tmp/rpc-dump.txt
curl -F'file=@/tmp/rpc-dump.txt' -A "raspberry-pi-community info reporter, <cameron@humaneyestudio.co.uk>" https://0x0.st