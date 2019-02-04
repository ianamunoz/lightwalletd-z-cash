#!/bin/bash

CUR_PATH=`pwd`

docker run -itd \
--name lightwalletd \
--mount source=testnet-chain,destination=/home/zcash/.zcash \
--mount source=testnet-params,destination=/home/zcash/.zcash-params \
-p 9067:9067 \
zcash-hackworks/lightwalletd:latest
