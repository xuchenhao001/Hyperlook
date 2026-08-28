#!/bin/bash

set -e

# netctl is its own build context, so without a manifest dep resolves
# fabric-sdk-go to @latest (v1.0.0-beta1), which no longer contains
# github.com/hyperledger/fabric-sdk-go/api/apitxn/chclient.
# Pin fabric-sdk-go to the revision this project is built against
# (same revision as the root Gopkg.toml).
FABRIC_SDK_GO_NAME="github.com/hyperledger/fabric-sdk-go"
FABRIC_SDK_GO_REVISION="614551a752802488988921a730b172dada7def1d"

dep ensure

# build netctl binary
CGO_ENABLED=0 go build

# build Docker image netctl:latest
docker build -t netctl:latest .
