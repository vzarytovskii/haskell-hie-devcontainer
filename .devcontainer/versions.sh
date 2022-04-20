#!/usr/bin/env bash

# Turn on command echo
set -xe

export GHC_VERSION=${GHC_VERSION:="8.10.7"}
export STACK_RESOLVER=${STACK_RESOLVER:="lts-18.19"}
export STACK_VERSION=${STACK_VERSION:="2.7.5"}
export CABAL_VERSION=${CABAL_VERSION:="3.6.2.0"}
export HLS_VERSION=${HLS_VERSION:="1.6.1.0"}
