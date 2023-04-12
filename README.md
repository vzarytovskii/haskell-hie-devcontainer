# (A highly opinionated) Docker image for Haskell development

**Note**: The way this container setup is very opinionaed, you may want to check out [an official dev containter for Haskell](https://github.com/microsoft/vscode-dev-containers/tree/main/containers/haskell).

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [(A highly opinionated) Docker image for Haskell development](#a-highly-opinionated-docker-image-for-haskell-development)
  - [Visual Studio Code: DevContainer for Haskell](#visual-studio-code-devcontainer-for-haskell)
    - [What is this](#what-is-this)
    - [How to use this](#how-to-use-this)
    - [How does it work](#how-does-it-work)
  - [What's in the box](#whats-in-the-box)
    - [How to build locally](#how-to-build-locally)

<!-- markdown-toc end -->

## Visual Studio Code: DevContainer for Haskell

### What is this

This is a DevContainer <sup>[[1](https://code.visualstudio.com/docs/remote/containers)][[2](https://code.visualstudio.com/docs/remote/containers-advanced)]</sup> environment for Visual Studio Code, allowing automatically installing the Haskell compiler (GHC), Stack, Cabal, HLS (Haskell Language Server), and the necessary Visual Studio Code extensions to set up a Haskell development environment with zero additional effort.

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

## What's in the box

[`.devcontainer/Dockerfile`](.devcontainer/Dockerfile) DevContainer Docker image.

[`debian:bullseye`](https://hub.docker.com/_/debian) as a base image.

Additional software installed:

- Glasgow Haskell Compiler (GHC) via [ghcup](https://www.haskell.org/ghcup/).
- A Haskell LSP server HLS - ([haskell-language-server](https://github.com/haskell/haskell-language-server)).
- [Stack](https://docs.haskellstack.org/en/stable/README/).
- [Cabal](https://www.haskell.org/cabal/).
- Following Debian packages: `apt-utils bash build-essential ca-certificates curl gcc git gnupg libffi-dev libffi7 libgmp-dev libgmp-dev libgmp10 libicu-dev libncurses-dev libncurses5 libnuma1 libnuma-dev libtinfo5 lsb-release make procps software-properties-common sudo wget xz-utils z3 zlib1g-dev`.
- Following Haskell packages (via [cabal](https://nixos.org/nixos/packages.html)): `haskell-dap ghci-dap haskell-debug-adapter hlint apply-refact retrie stylish-haskell hoogle ormolu liquidhaskell`.
- LLVM 12 via [LLVM Automatic installation script](https://apt.llvm.org/).

**NOTE:** *When changing GHC/HLS versions, please refer to the [GHC/HLS compatibility table](https://haskell-language-server.readthedocs.io/en/latest/supported-versions.html).*

Following VSCode extensions are installed after container is started:

- [Haskell extension](https://marketplace.visualstudio.com/items?itemName=haskell.haskell).
- [Haskell GHCi Debugger Adapter](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode).
- [Integrated Haskell Shell](https://marketplace.visualstudio.com/items?itemName=eriksik2.vscode-ghci).
- [Hoogle for VSCode](https://marketplace.visualstudio.com/items?itemName=jcanero.hoogle-vscode).

The [`devcontainer.json`](.devcontainer/devcontainer.json) has some additional configuration for VSCode, in particular, the required extensions that have to be installed, the name of the remote user (must match the one in the [`Dockerfile`](.devcontainer/Dockerfile)), and...⏎

<details>
<summary>... the following settings</summary>

```json
{
    "files.exclude": {
      "**/*.olean": true,
      "**/.DS_Store": true,
      "**/.git": true,
      "**/.hg": true,
      "**/.svn": true,
      "**/CVS": true
    },
    "haskell.checkProject": true,
    "haskell.formattingProvider": "ormolu",
    "haskell.indentationRules.enabled": true,
    "haskell.liquidOn": true,
    "haskell.manageHLS": "GHCup",
    "haskell.maxCompletions": 40,
    "haskell.openDocumentationInHackage": false,
    "haskell.openSourceInHackage": false,
    "haskell.plugin.alternateNumberFormat.globalOn": true,
    "haskell.plugin.callHierarchy.globalOn": true,
    "haskell.plugin.changeTypeSignature.globalOn": true,
    "haskell.plugin.class.globalOn": true,
    "haskell.plugin.eval.config.diff": true,
    "haskell.plugin.eval.config.exception": true,
    "haskell.plugin.eval.globalOn": true,
    "haskell.plugin.ghcide-code-actions-bindings.globalOn": true,
    "haskell.plugin.ghcide-code-actions-fill-holes.globalOn": true,
    "haskell.plugin.ghcide-code-actions-imports-exports.globalOn": true,
    "haskell.plugin.ghcide-code-actions-type-signatures.globalOn": true,
    "haskell.plugin.ghcide-completions.config.autoExtendOn": true,
    "haskell.plugin.ghcide-completions.config.snippetsOn": true,
    "haskell.plugin.ghcide-completions.globalOn": true,
    "haskell.plugin.ghcide-hover-and-symbols.hoverOn": true,
    "haskell.plugin.ghcide-hover-and-symbols.symbolsOn": true,
    "haskell.plugin.ghcide-type-lenses.config.mode": "always",
    "haskell.plugin.ghcide-type-lenses.globalOn": true,
    "haskell.plugin.haddockComments.globalOn": true,
    "haskell.plugin.hlint.codeActionsOn": true,
    "haskell.plugin.hlint.config.flags": [],
    "haskell.plugin.hlint.diagnosticsOn": true,
    "haskell.plugin.importLens.codeActionsOn": true,
    "haskell.plugin.importLens.codeLensOn": true,
    "haskell.plugin.moduleName.globalOn": true,
    "haskell.plugin.pragmas.codeActionsOn": true,
    "haskell.plugin.pragmas.completionOn": true,
    "haskell.plugin.qualifyImportedNames.globalOn": true,
    "haskell.plugin.refineImports.codeActionsOn": true,
    "haskell.plugin.refineImports.codeLensOn": true,
    "haskell.plugin.refineImports.globalOn": true,
    "haskell.plugin.rename.config.crossModule": true,
    "haskell.plugin.rename.globalOn": true,
    "haskell.plugin.retrie.globalOn": true,
    "haskell.plugin.splice.globalOn": true,
    "haskell.plugin.tactic.config.max_use_ctor_actions": 5,
    "haskell.plugin.tactics.codeActionsOn": true,
    "haskell.plugin.tactics.codeLensOn": true,
    "haskell.plugin.tactics.config.auto_gas": 4,
    "haskell.plugin.tactics.config.hole_severity": "hint",
    "haskell.plugin.tactics.config.max_use_ctor_actions": 5,
    "haskell.plugin.tactics.config.proofstate_styling": true,
    "haskell.plugin.tactics.config.timeout_duration": 5,
    "haskell.plugin.tactics.globalOn": true,
    "haskell.plugin.tactics.hoverOn": true,
    "haskell.trace.client": "error",
    "haskell.trace.server": "off",
    "haskell.upgradeGHCup": true,
    "hoogle-vscode.useCabalDependencies": true
}
```

</details>

This was initially based on the [DevContainer for HIE (Haskell IDE Engine)](https://github.com/hmemcpy/haskell-hie-devcontainer) by [Igal Tabachnik](https://github.com/hmemcpy).

### How to build locally

To build the image locally, just run `docker build ./.devcontainer/ --file ./.devcontainer/Dockerfile --tag haskelldevenv:latest` in the repository root.

You can override GHC version, Cabal version, Stack resolver and HLS version by specifying `GHC_VERSION=...`, `CABAL_VERSION=...`, `STACK_RESOLVER=...` and `HLS_VERSION=...` respectively as build args.

For example:

- `docker build ./.devcontainer/ --file ./.devcontainer/Dockerfile --tag haskelldevenv:latest --build-arg GHC_VERSION=8.10.7`
- `docker build ./.devcontainer/ --file ./.devcontainer/Dockerfile --tag haskelldevenv:latest --build-arg STACK_RESOLVER=lts-18.13`
- `docker build ./.devcontainer/ --file ./.devcontainer/Dockerfile --tag haskelldevenv:latest --build-arg CABAL_VERSION=3.6.2.0`
- `docker build ./.devcontainer/ --file ./.devcontainer/Dockerfile --tag haskelldevenv:latest --build-arg HLS_VERSION=1.5.1`
- `docker build ./.devcontainer/ --file ./.devcontainer/Dockerfile --tag haskelldevenv:latest --build-arg GHC_VERSION=8.8.4 --build-arg STACK_RESOLVER=lts-18.13 --build-arg CABAL_VERSION=3.6.2.0 --build-arg HLS_VERSION=1.5.1`

To run the image, just do `docker run --rm -it haskelldevenv:latest`.

Valid values for `GHC_VERSION` can be found [here](https://www.haskell.org/ghc/download.html).
