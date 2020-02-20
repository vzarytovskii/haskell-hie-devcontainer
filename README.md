# VSCode DevContainer for Haskell

## What is this

This is a DevContainer <sup>[[1](https://code.visualstudio.com/docs/remote/containers)][[2](https://code.visualstudio.com/docs/remote/containers-advanced)]</sup> environment for Visual Studio Code, allowing automatically installing the Haskell compiler (GHC), Stack, Cabal, HIE (Haskell IDE Engine), LiquidHaskell and the necessary Visual Studio Code extensions to set up a Haskell development environment with zero additional effort.

**Note**: For debugging support, please refer to [Haskell GHCi Debugger Adapter Phoityne](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode) extension documentation.

## How to use this

Follow the [Getting Started](https://code.visualstudio.com/docs/remote/containers#_getting-started) instructions to configure your Visual Studio Code and Docker to use with DevContainers.

Place the `.devcontainer` directory in the root of your project, and the next time you load the project, Visual Studio Code will prompt to re-open the project in a container:

![image](https://user-images.githubusercontent.com/601206/73298150-7bfac580-4215-11ea-81d3-a8fabab98e30.png)

**Note**: building the container might take a few minutes until all dependencies have finished downloading and installing.

## How does it work

Visual Studio Code supports [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers) - using a Docker image as a development environment. It automates the process of creating the container image, as well as installing additional required extensions into the editor.

Pressing **Reopen in Container** will perform the automated steps to launch the container, and set up the environment.

For more information and setup, read the official documentation: <https://code.visualstudio.com/docs/remote/containers> and <https://code.visualstudio.com/docs/remote/containers-advanced>

## What's in the box

[`Dockerfile`](.devcontainer/Dockerfile) contains the following:

An image, based on [`nixos/nix/`](https://hub.docker.com/r/nixos/nix/), an Alpine image that contains the [Nix package manager](https://nixos.org/nix/).

Additional software installed:

* Configuration for [Cachix](https://cachix.org/) - a binary cache for Nix
* Glasgow Haskell Compiler (GHC) version 8.6.5
* HIE ([haskell-ide-engine](https://github.com/haskell/haskell-ide-engine)) for GHC 8.6.5
* [Stack](https://docs.haskellstack.org/en/stable/README/)
* [Cabal](https://www.haskell.org/cabal/) for GHC 8.6.5
* [LiquidHaskell](https://ucsd-progsys.github.io/liquidhaskell-blog/)
* Following haskell packages (via [nix](https://nixos.org/nixos/packages.html)): `hlint, hindent, phoityne-vscode, haskell-dap, liquidhaskell, liquidhaskell-cabal, stylish-haskell`.
* Following Alpine (via [apk](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management)): `ca-certificates, git, openssh-client, less, bash, libgcc, libstdc++, curl, procps, coreutils, krb5-libs, libintl, libssl1.1, lttng-ust, tzdata, userspace-rcu, zlib, shadow, sudo`.

Following VSCode extensions are installed after container is started:

* [Haskell Syntax Highlighting](https://marketplace.visualstudio.com/items?itemName=justusadam.language-haskell).
* [Haskell Language Server](https://marketplace.visualstudio.com/items?itemName=alanz.vscode-hie-server).
* [Haskell GHCi Debugger Adapter Phoityne](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode).
* [Integrated Haskell Shell](https://marketplace.visualstudio.com/items?itemName=eriksik2.vscode-ghci).
* [Haskutil](https://marketplace.visualstudio.com/items?itemName=edka.haskutil)
* [Haskell Code Formatter](https://marketplace.visualstudio.com/items?itemName=sergey-kintsel.haskell-formatter-vscode-extension)

The [`devcontainer.json`](.devcontainer/devcontainer.json) has some additional configuration for VSCode, in particular, the required extensions that have to be installed, and the name of the remote user (must match the one in the [`Dockerfile`](.devcontainer/Dockerfile)).

This is based on the [Alpine devcontainer](https://github.com/microsoft/vscode-dev-containers/tree/master/containers/alpine-3.10-git/.devcontainer) from Microsoft and [DevContainer for HIE (Haskell IDE Engine)](https://github.com/hmemcpy/haskell-hie-devcontainer) by [Igal Tabachnik](https://github.com/hmemcpy).
