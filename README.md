# Docker image for Haskell development

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Docker image for Haskell development](#docker-image-for-haskell-development)
    - [Visual Studio Code: DevContainer for Haskell](#visual-studio-code-devcontainer-for-haskell)
        - [What is this](#what-is-this)
        - [How to use this](#how-to-use-this)
        - [How does it work](#how-does-it-work)
    - [Emacs: lsp-docker](#emacs-lsp-docker)
        - [What is this](#what-is-this-1)
        - [How to use this](#how-to-use-this-1)
        - [How does it work](#how-does-it-work-1)
    - [What's in the box](#whats-in-the-box)
        - [How to build locally](#how-to-build-locally)

<!-- markdown-toc end -->


## Visual Studio Code: DevContainer for Haskell

### What is this

This is a DevContainer <sup>[[1](https://code.visualstudio.com/docs/remote/containers)][[2](https://code.visualstudio.com/docs/remote/containers-advanced)]</sup> environment for Visual Studio Code, allowing automatically installing the Haskell compiler (GHC), Stack, Cabal, HIE (Haskell IDE Engine), LiquidHaskell and the necessary Visual Studio Code extensions to set up a Haskell development environment with zero additional effort.

**Note**: For debugging support, please refer to [Haskell GHCi Debugger Adapter Phoityne](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode) extension documentation.

### How to use this

Follow the [Getting Started](https://code.visualstudio.com/docs/remote/containers#_getting-started) instructions to configure your Visual Studio Code and Docker to use with DevContainers.

Place the `.devcontainer` directory in the root of your project, and the next time you load the project, Visual Studio Code will prompt to re-open the project in a container:

![image](https://user-images.githubusercontent.com/601206/73298150-7bfac580-4215-11ea-81d3-a8fabab98e30.png)

**Note**: building the container might take a few minutes until all dependencies have finished downloading and installing.

### How does it work

Visual Studio Code supports [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers) - using a Docker image as a development environment. It automates the process of creating the container image, as well as installing additional required extensions into the editor.

Pressing **Reopen in Container** will perform the automated steps to launch the container, and set up the environment.

For more information and setup, read the official documentation: <https://code.visualstudio.com/docs/remote/containers> and <https://code.visualstudio.com/docs/remote/containers-advanced>

## Emacs: lsp-docker

### What is this

TODO

### How to use this

TODO

### How does it work

TODO

## What's in the box (TODO: Move containers around)
[`.devcontainer/Dockerfile`](.devcontainer/Dockerfile) DevContainer Docker image, using pre-built "source" image as a base from the dockerhub, to avoid waiting for image building too much.

[`Dockerfile.source`](Dockerfile.source) "source" image, contains the following:

[`debian:buster`](https://hub.docker.com/_/debian) as a base image.

Additional software installed:

* Glasgow Haskell Compiler (GHC) version 8.8.3 via ghcup-hs.
* A Haskell LSP server, one of the:
  * HIE ([haskell-ide-engine](https://github.com/haskell/haskell-ide-engine)) - Selected by default.
  * HLS ([haskell-language-server](https://github.com/haskell/haskell-language-server)).
  * GHCIDE ([haskell-ide-engine](https://github.com/haskell/haskell-ide-engine)).
* [Stack](https://docs.haskellstack.org/en/stable/README/).
* [Cabal](https://www.haskell.org/cabal/).
* Following Debian packages: `git, curl, xz-utils, gcc, make, libtinfo5, libgmp-dev, zlib1g-dev, bash, sudo, procps, lsb-release, ca-certificates, build-essential, curl, libffi-dev, libffi6, libgmp-dev, libgmp10, libncurses-dev, libncurses5, libtinfo5, libicu-dev, libncurses-dev, z3`.
* Following haskell packages (via [cabal](https://nixos.org/nixos/packages.html)): `alex, c2hs, cpphs, doctest, greencard, happy hlint, phoityne-vscode, haskell-dap, liquidhaskell, stylish-haskell, hoogle, retrie`.

Following VSCode extensions are installed after container is started:

* [Haskell Syntax Highlighting](https://marketplace.visualstudio.com/items?itemName=justusadam.language-haskell).
* [Haskell Language Server](https://marketplace.visualstudio.com/items?itemName=alanz.vscode-hie-server).
* [Haskell GHCi Debugger Adapter Phoityne](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode).
* [Integrated Haskell Shell](https://marketplace.visualstudio.com/items?itemName=eriksik2.vscode-ghci).
* [Haskutil](https://marketplace.visualstudio.com/items?itemName=edka.haskutil).
* [Haskell Code Formatter](https://marketplace.visualstudio.com/items?itemName=sergey-kintsel.haskell-formatter-vscode-extension).
* [LiquidHaskell](https://marketplace.visualstudio.com/items?itemName=MustafaHafidi.liquidhaskell-diagnostics).

The [`devcontainer.json`](.devcontainer/devcontainer.json) has some additional configuration for VSCode, in particular, the required extensions that have to be installed, and the name of the remote user (must match the one in the [`Dockerfile`](.devcontainer/Dockerfile)).

This was initially based on the [DevContainer for HIE (Haskell IDE Engine)](https://github.com/hmemcpy/haskell-hie-devcontainer) by [Igal Tabachnik](https://github.com/hmemcpy).

### How to build locally

To build "source" image locally, just run `docker build . --file ./Dockerfile.source --tag haskelldevenv:latest` from the repository root.

You can override GHC version, and LSP flavour/backend by specifying `-e"GHC_VERSION=x.x.x` and `-e"HASKELL_LSP_FLAVOUR=xxx"` respectively, for example:
* `docker build . --file ./Dockerfile.source --tag haskelldevenv:latest -e"GHC_VERSION=8.6.5"`
* `docker build . --file ./Dockerfile.source --tag haskelldevenv:latest -e"HASKELL_LSP_FLAVOUR=hls"`
* `docker build . --file ./Dockerfile.source --tag haskelldevenv:latest -e"GHC_VERSION=8.6.5 -e"HASKELL_LSP_LFAVOUR=all"`

Valid values for `GHC_VERSION` can be found [here](https://www.haskell.org/ghc/download.html), `HASKELL_LSP_FLAVOUR` can be one of `hie` (default), `hls`, `ghcide` and `all`.

__Please NOTE__, that if you're building the image from scratch, it can take pretty significant time, since it will be compiling most of the libraries from source.


