#!/bin/bash

MY_IP="$(hostname -i | awk '{print $1}')"
MY_ID="$(tr -d . <<<"$MY_IP")"
echo "MY_IP=$MY_IP"
echo "MY_ID=$MY_ID"

declare -a ips
while [[ ${#ips[@]} -ne $PEER_NUMBER ]]; do
    echo "Waiting for all $PEER_NUMBER containers to spawn..."
    ips=($(getent hosts tasks.bft-server | sort | awk '{print $1}'))
    sleep 1
done

for ip in "${ips[@]}"; do
    peerid="$(tr -d . <<<"$ip")"
    printf "%s %s 11000\n" "$peerid" "$ip"
done >config/hosts.config

runscripts/smartrun.sh bftsmart.demo.microbenchmarks.LatencyServer "$MY_ID" 1000 300
