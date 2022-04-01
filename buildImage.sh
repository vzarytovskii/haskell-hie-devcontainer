#!/usr/bin/env bash

docker build . --tag ghcr.io/daniel-pittman/haskell-dev-env:latest \
    --build-arg GHC_VERSION=8.10.7 \
    --build-arg STACK_RESOLVER=lts-18.19 \
    --build-arg STACK_VERSION=2.7.5 \
    --build-arg CABAL_VERSION=3.6.2.0 \
    --build-arg HLS_VERSION=1.6.1.0

# docker push ghcr.io/daniel-pittman/haskell-dev-env:latest
