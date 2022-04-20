#!/usr/bin/env bash

# Turn on command echo
set -xe

source ./versions.sh

docker buildx create --buildkitd-flags '--oci-worker-gc --oci-worker-gc-keepstorage 50000' --name "multi-arch-builder" --use || true

#    --platform="linux/arm64,linux/amd64" \
#    --push \
docker buildx build \
  --tag ghcr.io/daniel-pittman/haskell-dev-env:latest-$(uname -m) \
  --tag ghcr.io/daniel-pittman/haskell-dev-env:ghc_${GHC_VERSION}-resolver_${STACK_RESOLVER}-stack_${STACK_VERSION}-ghc_${GHC_VERSION}-hls_${HLS_VERSION}-$(uname -m) \
  --build-arg GHC_VERSION=${GHC_VERSION} \
  --build-arg STACK_RESOLVER=${STACK_RESOLVER} \
  --build-arg STACK_VERSION=${STACK_VERSION} \
  --build-arg CABAL_VERSION=${CABAL_VERSION} \
  --build-arg HLS_VERSION=${HLS_VERSION} \
  "$@" \
  .

docker manifest inspect --verbose ghcr.io/daniel-pittman/haskell-dev-env:ghc_${GHC_VERSION}-resolver_${STACK_RESOLVER}-stack_${STACK_VERSION}-ghc_${GHC_VERSION}-hls_${HLS_VERSION}-$(uname -m)

