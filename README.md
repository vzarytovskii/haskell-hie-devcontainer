# A prebuilt Docker-based environment for Haskell development

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Docker image for Haskell development](#docker-image-for-haskell-development)
  - [Visual Studio Code: DevContainer for Haskell](#visual-studio-code-devcontainer-for-haskell)
    - [What is this](#what-is-this)
    - [How to use this](#how-to-use-this)
    - [How does it work](#how-does-it-work)
  - [What's in the box](#whats-in-the-box)
    - [How to build locally](#how-to-build-locally)

<!-- markdown-toc end -->

## Visual Studio Code: DevContainer for Haskell

### What is this?

This is a DevContainer <sup>[[1](https://code.visualstudio.com/docs/remote/containers)][[2](https://code.visualstudio.com/docs/remote/containers-advanced)]</sup> environment for Visual Studio Code, allowing automatically installing the Haskell compiler (GHC), Stack, Cabal, HLS (Haskell Language Server), and the necessary Visual Studio Code extensions to set up a Haskell development environment with zero additional effort. The project also contains stack templates that will be used when creating projects within the DevContainer environment.

**Note**: For debugging support, please refer to [Haskell GHCi Debugger Adapter Phoityne](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode) extension documentation.

### How to use this project template

Follow the [Getting Started](https://code.visualstudio.com/docs/remote/containers#_getting-started) instructions to configure your Visual Studio Code and Docker to use with DevContainers.

The first time you open the project in Visual Studio (VS) Code, it will prompt to re-open the project in a container:

![image](https://user-images.githubusercontent.com/601206/73298150-7bfac580-4215-11ea-81d3-a8fabab98e30.png)

Once you reopen the project it will download the latest Docker image from GitHub and use that as a the runtime for the project.

**Note**: downloading the image from GitHub might take a few minutes to complete.

### How does it work?

Visual Studio Code supports [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers) - using a Docker image as a development environment. It automates the process of creating the container image, as well as installing additional required extensions into the editor.

Pressing **Reopen in Container** will perform the automated steps to launch the container, and set up the environment.

For more information and setup, read the official documentation: <https://code.visualstudio.com/docs/remote/containers> and <https://code.visualstudio.com/docs/remote/containers-advanced>

## What's in the box

[`.devcontainer/Dockerfile`](.devcontainer/Dockerfile) DevContainer Docker image.

[`stack-templates`](stack-templates) provides templates for the [Haskell Tool Stack](https://docs.haskellstack.org/en/stable/README/)

Additional software installed:

- Glasgow Haskell Compiler (GHC) via [ghcup](https://www.haskell.org/ghcup/).
- A Haskell LSP server HLS - ([haskell-language-server](https://github.com/haskell/haskell-language-server)).
- [Stack](https://docs.haskellstack.org/en/stable/README/).
- [Cabal](https://www.haskell.org/cabal/).
- Following Debian packages: `apt-utils, git, curl, xz-utils, gcc, make, libtinfo5, libgmp-dev, zlib1g-dev, bash, sudo, procps, lsb-release, ca-certificates, build-essential, curl, libffi-dev, libffi7, libgmp-dev, libgmp10, libncurses-dev, libncurses5, libtinfo5, libicu-dev, libncurses-dev, z3`.
- Following Haskell packages (via [cabal](https://nixos.org/nixos/packages.html)): `haskell-dap ghci-dap haskell-debug-adapter hlint apply-refact retrie stylish-haskell hoogle ormolu liquidhaskell`.

Following VSCode extensions are installed after container is started:

- [Haskell extension](https://marketplace.visualstudio.com/items?itemName=haskell.haskell).
- [Haskell GHCi Debugger Adapter](https://marketplace.visualstudio.com/items?itemName=phoityne.phoityne-vscode).
- [Integrated Haskell Shell](https://marketplace.visualstudio.com/items?itemName=eriksik2.vscode-ghci).
- [Hoogle for VSCode](https://marketplace.visualstudio.com/items?itemName=jcanero.hoogle-vscode).

[`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) provides the configuration to VS Code about how to download and run the Docker image. It also has some additional configuration for VSCode, in particular, the required extensions that have to be installed, the name of the remote user (must match the one in the [`Dockerfile`](.devcontainer/Dockerfile)), and the following settings:

```json
{
    "haskell.formattingProvider": "ormolu",
    "haskell.openDocumentationInHackage": false,
    "haskell.openSourceInHackage": false,
    "haskell.trace.server": "off",
    "haskell.trace.client": "error",
    "haskell.checkProject": true,
    "haskell.maxCompletions": 40,
    "haskell.plugin.importLens.codeActionsOn": true,
    "haskell.plugin.importLens.codeLensOn": true,
    "haskell.plugin.hlint.codeActionsOn": true,
    "haskell.plugin.hlint.diagnosticsOn": true,
    "haskell.plugin.eval.globalOn": true,
    "haskell.plugin.moduleName.globalOn": true,
    "haskell.plugin.splice.globalOn": true,
    "haskell.plugin.haddockComments.globalOn": true,
    "haskell.plugin.class.globalOn": true,
    "haskell.plugin.retrie.globalOn": true,
    "haskell.plugin.tactics.globalOn": true,
    "haskell.plugin.tactics.config.hole_severity": "hint",
    "haskell.plugin.tactic.config.max_use_ctor_actions": 5,
    "haskell.plugin.tactics.config.timeout_duration": 5,
    "haskell.plugin.tactics.config.proofstate_styling": true,
    "haskell.plugin.pragmas.codeActionsOn": true,
    "haskell.plugin.pragmas.completionOn": true,
    "haskell.plugin.ghcide-completions.config.autoExtendOn": true,
    "haskell.plugin.ghcide-completions.config.snippetsOn": true,
    "haskell.plugin.ghcide-type-lenses.globalOn": true,
    "haskell.plugin.refineImports.globalOn": true,
    "haskell.hlintOn": true,
    "haskell.diagnosticsOnChange": true,
    "haskell.liquidOn": true,
    "haskell.completionSnippetsOn": true,
    "haskell.formatOnImportOn": true,
    "haskell.languageServerVariant": "haskell-language-server",
    "hoogle-vscode.useCabalDependencies": true,
    "files.exclude": {
        "**/.git": true,
        "**/.svn": true,
        "**/.hg": true,
        "**/CVS": true,
        "**/.DS_Store": true,
        "**/*.olean": true
    },
}
```

This version of the VS Code Haskell environment was forked from [(A highly opinionated) Docker image for Haskell development](https://github.com/vzarytovskii/haskell-dev-env) by [Vlad Zarytovskii](https://github.com/vzarytovskii).

### How to build locally

To build the image locally, just run `build-image.sh` from inside the `.devcontainer` directory.

You can override GHC version, Cabal version, Stack resolver and HLS version by specifying `GHC_VERSION=...`, `CABAL_VERSION=...`, `STACK_VERSION=...`, `STACK_RESOLVER=...` and `HLS_VERSION=...` environment variables when running the `build-image.sh` script.

For example:

- `GHC_VERSION=8.10.7 STACK_RESOLVER=lts-18.19 STACK_VERSION=2.7.5 CABAL_VERSION=3.6.2.0 HLS_VERSION=1.6.1.0 ./build-image.sh`

To run the image, just do `docker run --rm -it ghcr.io/daniel-pittman/haskell-dev-env:latest`.

Valid values for `GHC_VERSION` can be found [here](https://www.haskell.org/ghc/download.html).
