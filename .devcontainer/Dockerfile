FROM debian:buster

ENV GHC_VERSION=8.8.3 \
    STACK_RESOLVER=lts-15.14 \
    HLS_VERSION=master \
    HIE_VERSION=master \
    HASKELL_LSP_FLAVOUR=hie \
    USERNAME=haskeller \
    USER_UID=2001 \
    USER_GID=2001 \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends git curl xz-utils gcc make libtinfo5 libgmp-dev zlib1g-dev bash sudo procps lsb-release ca-certificates build-essential curl libffi-dev libffi6 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 libicu-dev libncurses-dev z3

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd -ms /bin/bash -K MAIL_DIR=/dev/null --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER ${USER_UID}:${USER_GID}
WORKDIR /home/${USERNAME}
ENV PATH="/home/${USERNAME}/.local/bin:/home/${USERNAME}/.cabal/bin:/home/${USERNAME}/.ghcup/bin:$PATH"


ARG BOOTSTRAP_HASKELL_NONINTERACTIVE=yes
RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Check if needed GHC_VERSION was already installed during bootstrap, otherwise - install it.
RUN echo "Checking if requested GHC version is already installed" && \
    if ghcup list 2>&1 | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | grep -P "\xE2\x9C\x94\sghc\s+${GHC_VERSION}\s+\w+" ; \
    then \
         echo "GHC ${GHC_VERSION} is already installed via ghcup." ; \
    else \
         echo "GHC ${GHC_VERSION} was not found. Installing via ghcup." && \
         ghcup install ${GHC_VERSION} ; \
    fi
RUN ghcup set ${GHC_VERSION}

# Upgrade Cabal
RUN ghcup install-cabal && cabal update && cabal new-install cabal-install

# To init global-project
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN ((stack ghc -- --version 2>/dev/null) || true) && \
    # Set global defaults for stack.
    stack config --system-ghc set system-ghc --global true && \
    stack config --system-ghc set install-ghc --global false && \
    stack config --system-ghc set resolver $STACK_RESOLVER

# Install LSP (either hie or hls)
RUN echo "Installing \"${HASKELL_LSP_FLAVOUR}\" LSP server" && \
    if [ hie = "${HASKELL_LSP_FLAVOUR}" -o all = "${HASKELL_LSP_FLAVOUR}" ] ; \
    then \
        git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules && \
        cd haskell-ide-engine && \
        git checkout ${HIE_VERSION} && \
        ./cabal-hie-install hie && \
        ./cabal-hie-install data; \
    elif [ hls = "${HASKELL_LSP_FLAVOUR}" -o all = "${HASKELL_LSP_FLAVOUR}" ] ; \
    then \
        git clone https://github.com/haskell/haskell-language-server --recurse-submodules && \
        cd haskell-language-server && \
        git checkout ${HLS_VERSION} && \
        ./cabal-hls-install hls && \
        ./cabal-hls-install data; \
    elif [ ghcide == "${HASKELL_LSP_FLAVOUR}" -o all = "${HASKELL_LSP_FLAVOUR}" ] ; \
    then \
        cabal install ghcide ; \
    else \
        echo "Unknown LSP flavour \"${HASKELL_LSP_FLAVOUR}\". Valid options are \"hie\", \"hls\", \"ghcide\" or \"all\"" 1>&2 && exit 1; \
    fi

# Install packages
RUN cabal install phoityne-vscode alex c2hs cpphs doctest happy liquidhaskell haskell-dap hlint hindent stylish-haskell hoogle retrie QuickCheck

ENV DEBIAN_FRONTEND=dialog
ENTRYPOINT ["/bin/bash"]
