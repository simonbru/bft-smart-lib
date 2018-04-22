#!/bin/bash

declare -a ips
ips=($(getent hosts tasks.bft-server | sort | awk '{print $1}'))

current_id=0
for ip in "${ips[@]}"; do
    printf "%s %s 11000\n" "$current_id" "$ip"
    ((current_id++))
done >config/hosts.config
