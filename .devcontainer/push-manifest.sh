#!/usr/bin/env bash

# Turn on command echo
set -xe

source ./versions.sh

docker manifest create ghcr.io/daniel-pittman/haskell-dev-env:latest ghcr.io/daniel-pittman/haskell-dev-env:latest-arm64 ghcr.io/daniel-pittman/haskell-dev-env:latest-x86_64
docker manifest push --purge ghcr.io/daniel-pittman/haskell-dev-env:latest

docker manifest create ghcr.io/daniel-pittman/haskell-dev-env:ghc_${GHC_VERSION}-resolver_${STACK_RESOLVER}-stack_${STACK_VERSION}-ghc_${GHC_VERSION}-hls_${HLS_VERSION} ghcr.io/daniel-pittman/haskell-dev-env:ghc_${GHC_VERSION}-resolver_${STACK_RESOLVER}-stack_${STACK_VERSION}-ghc_${GHC_VERSION}-hls_${HLS_VERSION}-arm64 ghcr.io/daniel-pittman/haskell-dev-env:ghc_${GHC_VERSION}-resolver_${STACK_RESOLVER}-stack_${STACK_VERSION}-ghc_${GHC_VERSION}-hls_${HLS_VERSION}-x86_64
docker manifest push --purge ghcr.io/daniel-pittman/haskell-dev-env:ghc_${GHC_VERSION}-resolver_${STACK_RESOLVER}-stack_${STACK_VERSION}-ghc_${GHC_VERSION}-hls_${HLS_VERSION}
