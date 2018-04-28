#!/bin/bash

./genhosts.sh
exec runscripts/smartrun.sh bftsmart.demo.microbenchmarks.LatencyClient "55${PEER_ID}" "${@}"
