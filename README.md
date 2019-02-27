Collaborated heavily with Boltlabs



# Build a zcashd node from multi-container Docker build

```
cd ./Dockerfiles/zcashd
bash build-image.sh
```

# Create docker volumes and populate the `zcash-params` volume

See example scripts `create_mainnet_params_volume.sh`. Change accordingly for testnet.

# Build a monolith container with lightwallet node and zcashd node from multi-container Docker build

```
cd ./Dockerfiles/lightwalletd
bash build-image.sh
```

Fetch params into a volume:
```
docker run --rm -itd \
--user zcash \
--mount source=testnet-params,destination=/home/zcash/.zcash-params \
zcash-hackworks/lightwalletd:latest bash -c "fetch-params.sh"
```

To follow progress run:
```
docker logs -f `docker ps | grep lightwalletd | cut -d' ' -f1`
```


Run the container. Make sure you have whatever firewall open on port 9067.

```
bash Dockerfiles/lightwalletd/run_zcashd_container.sh
```

# Check that it is running

Fetch [docker-grpcurl](https://github.com/datawire/docker-grpcurl)

```
curl -LO https://raw.githubusercontent.com/datawire/docker-grpcurl/master/grpcurl.sh && chmod +x grpcurl.sh
```
(I had to remove the 'set' in that script for it to run)

Check the API is up. It will return the latest block indexed into lightwallet db.
```
./grpcurl.sh -plaintext localhost:9067 cash.z.wallet.sdk.rpc.CompactTxStreamer/GetLatestBlock
{
  "height": ${SOME_INTEGER_HEIGHT}
}
```

# ToDo

1. TLS termination via load balancer or through gRPC library.
2. Finish and clean up `docker-compose.yml` stack deploy.
