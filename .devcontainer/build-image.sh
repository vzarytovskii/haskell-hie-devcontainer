#!/usr/bin/env bash

# Turn on command echo
set -xe

GHC_VERSION=${GHC_VERSION:="8.10.7"}
STACK_RESOLVER=${STACK_RESOLVER:="lts-18.19"}
STACK_VERSION=${STACK_VERSION:="2.7.5"}
CABAL_VERSION=${CABAL_VERSION:="3.6.2.0"}
HLS_VERSION=${HLS_VERSION:="1.6.1.0"}

docker buildx build \
    --tag ghcr.io/daniel-pittman/haskell-dev-env:latest \
    --tag ghcr.io/daniel-pittman/haskell-dev-env:ghc_${GHC_VERSION}-resolver_${STACK_RESOLVER}-stack_${STACK_VERSION}-ghc_${GHC_VERSION}-hls_${HLS_VERSION} \
    --push --platform=linux/arm64,linux/amd64 \
    --build-arg GHC_VERSION=${GHC_VERSION} \
    --build-arg STACK_RESOLVER=${STACK_RESOLVER} \
    --build-arg STACK_VERSION=${STACK_VERSION} \
    --build-arg CABAL_VERSION=${CABAL_VERSION} \
    --build-arg HLS_VERSION=${GHC_VERSION} \
    .
