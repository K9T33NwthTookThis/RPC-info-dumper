#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  printf "This script must be run as root"
  exit 1
fi

printf "version info:\n" >/tmp/rpc-dump.txt
{
  # pi model/device
  uname -a
  printf "\n"
  cat /proc/version

  printf "\n\n journalctl:\n"
  journalctl -n 50 --no-pager

  printf "\n\n dmesg:\n"
  dmesg -H | tail -50

  printf "\n\n storage:\n"
  df -h

  printf "\n\n cpu info:\n"
  lscpu

  printf "\n\n pci:\n"
  lspci

  printf "\n\n uptime:\n"
  uptime
} >>/tmp/rpc-dump.txt

# Remove non system user names on system
getent passwd | while IFS=: read -r name _ uid _ _ _ _; do
  # System accounts shouldn't be redacted, as well as some user accounts
  if ((uid < 1000)); then
    continue
  fi

  awk -v user="$name" '{gsub(user, "[REDACTED]"); print}' /tmp/rpc-dump.txt | tee /tmp/rpc-dump-stripped.txt &>/dev/null
done

cat /tmp/rpc-dump-stripped.txt
rm /tmp/rpc-dump.txt

printf "                                                          
                                                          __ 
 _____ _____ _____ ____     _____ _____ __    _____ _ _ _|  |
| __  |   __|  _  |    \   | __  |   __|  |  |     | | | |  |
|    -|   __|     |  |  |  | __ -|   __|  |__|  |  | | | |__|
|__|__|_____|__|__|____/   |_____|_____|_____|_____|_____|__|\n"
printf "\nSend this link to the person who asked you to run this:\n"
curl -F'file=@/tmp/rpc-dump-stripped.txt' -A "raspberry-pi-community info reporter, <cameron@humaneyestudio.co.uk>" https://0x0.st
