#!/bin/bash

export TAG=v2.0.2
docker build --build-arg TAG -t zcash-hackworks/zcashd-lite:$TAG --memory-swap -1 .
