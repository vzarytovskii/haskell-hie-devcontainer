# DevContainer for Haskell (GHC 8.8.1, Cabal, HIE, LiquidHaskell)

## What is this

This is a [DevContainer](https://code.visualstudio.com/docs/remote/containers) environment for Visual Studio Code, allowing automatically installing the Haskell compiler (GHC), HIE (Haskell IDE Engine), Cabal, LiquidHaskell and the necessary Visual Studio Code extensions to set up a Haskell development environment with zero additional effort.

## How to use this

Follow the [Getting Started](https://code.visualstudio.com/docs/remote/containers#_getting-started) instructions to configure your Visual Studio Code and Docker to use with DevContainers.

Place the `.devcontainer` directory in the root of your project, and the next time you load the project, Visual Studio Code will prompt to re-open the project in a container:

![image](https://user-images.githubusercontent.com/601206/73298150-7bfac580-4215-11ea-81d3-a8fabab98e30.png)

**Note**: building the container might take a few minutes until all dependencies have finished downloading.

## How does it work

Visual Studio Code supports [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers) - using a Docker image as a development environment. It automates the process of creating the container image, as well as installing additional required extensions into the editor.

Pressing **Reopen in Container** will perform the automated steps to launch the container, and set up the environment.

For more information and setup, read the official documentation: <https://code.visualstudio.com/docs/remote/containers>

## What's in the box

The `Dockerfile` contains the following:

1. An image, based on [`nixos/nix/`](https://hub.docker.com/r/nixos/nix/), an Alpine image that contains the [Nix package manager](https://nixos.org/nix/), as well as the following:
   * Configuration for [Cachix](https://cachix.org/) - a binary cache for Nix
   * Glasgow Haskell Compiler (GHC) version 8.8.1
   * HIE ([haskell-ide-engine](https://github.com/haskell/haskell-ide-engine)) for GHC 8.8.1
   * [Cabal](https://www.haskell.org/cabal/) for GHC 8.8.1
   * [LiquidHaskell](https://ucsd-progsys.github.io/liquidhaskell-blog/)
2. A script to install some additional tools (such as git), as well as configuring a special user `vscode` to allow access from VSCode.

The `devcontainer.json` has some additional configuration for VSCode, in particular, the required extensions that have to be installed, and the name of the remote user (must match the one in the `Dockerfile`).

This is based on the [Alpine devcontainer](https://github.com/microsoft/vscode-dev-containers/tree/master/containers/alpine-3.10-git/.devcontainer) from Microsoft and [DevContainer for HIE (Haskell IDE Engine)](https://github.com/hmemcpy/haskell-hie-devcontainer) by [Igal Tabachnik](https://github.com/hmemcpy).
