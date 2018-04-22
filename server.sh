#!/bin/bash

MY_IP="$(hostname -i | awk '{print $1}')"
echo "MY_IP=$MY_IP"

declare -a ips
while [[ ${#ips[@]} -ne $PEER_NUMBER ]]; do
    echo "Waiting for all $PEER_NUMBER containers to spawn..."
    ips=($(getent hosts tasks.bft-server | sort | awk '{print $1}'))
    sleep 1
done

current_id=0
for ip in "${ips[@]}"; do
    if [[ "$ip" == "$MY_IP" ]]; then
        MY_ID=$current_id
    fi
    printf "%s %s 11000\n" "$current_id" "$ip"
    ((current_id++))
done >config/hosts.config

echo "MY_ID=$MY_ID"

exec runscripts/smartrun.sh bftsmart.demo.counter.CounterServer "$MY_ID"
# exec runscripts/smartrun.sh bftsmart.demo.microbenchmarks.LatencyServer "$MY_ID" 200 300
