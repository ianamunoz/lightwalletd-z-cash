#!/bin/bash

export TAG=latest
docker build --build-arg TAG -t zcash-hackworks/lightwalletd:$TAG --memory-swap -1 .
