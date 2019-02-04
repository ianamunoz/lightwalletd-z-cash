#!/bin/bash

docker volume create mainnet-params

docker run --rm -itd \
--mount source=mainnet-params,destination=/home/zcash/.zcash-params \
zcash-hackworks/zcashd-lite:latest bash -c "fetch-params.sh"

docker exec -it zcashd-params bash -c "fetch-params.sh"

# Verify that fetch-params a success
docker exec -it zcashd-params bash -c "ls /home/zcash/.zcash-params"

docker stop zcashd-params
docker rm zcashd-params
