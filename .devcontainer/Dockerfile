FROM debian:stable

ARG GHC_VERSION=8.10.7
ARG STACK_RESOLVER=lts-18.13
ARG CABAL_VERSION=3.6.2.0

ENV USERNAME=haskeller \
    USER_UID=2001 \
    USER_GID=2001 \
    DEBIAN_FRONTEND=noninteractive \
    GHC_VERSION=${GHC_VERSION} \
    STACK_RESOLVER=${STACK_RESOLVER} \
    CABAL_VERSION=${CABAL_VERSION}

RUN apt-get update
RUN apt-get install -y --no-install-recommends  apt-utils git curl xz-utils gcc make libtinfo5 libgmp-dev zlib1g-dev bash sudo procps lsb-release ca-certificates build-essential curl libffi-dev libffi7 libgmp-dev libgmp10 libncurses-dev libncurses5 libtinfo5 libicu-dev libncurses-dev z3

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd -ms /bin/bash -K MAIL_DIR=/dev/null --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER ${USER_UID}:${USER_GID}
WORKDIR /home/${USERNAME}
ENV PATH="/home/${USERNAME}/.local/bin:/home/${USERNAME}/.cabal/bin:/home/${USERNAME}/.ghcup/bin:$PATH"

RUN echo "export PATH=$PATH" >> /home/$USERNAME/.profile

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=yes \
    BOOTSTRAP_HASKELL_NO_UPGRADE=yes

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Check if needed GHC_VERSION was already installed during bootstrap, otherwise - install it.
RUN echo "Checking, whether GHC(${GHC_VERSION}) is already installed" && \
    if ghcup list 2>&1 | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" | grep -P "\xE2\x9C\x94\sghc\s+${GHC_VERSION}\s+\w+" ; \
    then \
        echo "GHC ${GHC_VERSION} is already installed via ghcup." ; \
    else \
        echo "GHC ${GHC_VERSION} was not found. Installing via ghcup." && \
        ghcup install ghc ${GHC_VERSION} ; \
    fi

# Set the GHC version.
RUN ghcup set ghc ${GHC_VERSION}

# Install cabal-iinstall
RUN ghcup install cabal ${CABAL_VERSION}

# Update Cabal.
RUN cabal update && cabal new-install cabal-install

# Configure cabal
RUN cabal user-config update -f && \
    sed -i 's/-- ghc-options:/ghc-options: -haddock/g' ~/.cabal/config

# Install stack
RUN curl -sSL https://get.haskellstack.org/ | sh

# Init global-project.
RUN ghcup install stack

# Set system-ghc, install-ghc and resolver for stack.
RUN ((stack ghc -- --version 2>/dev/null) || true) && \
    # Set global defaults for stack.
    stack config --system-ghc set system-ghc true --global && \
    stack config --system-ghc set install-ghc false --global && \
    stack config --system-ghc set resolver $STACK_RESOLVER

# Set global custom defaults for stack.
RUN printf "ghc-options:\n  \"\$everything\": -haddock\n" >> /home/${USERNAME}/.stack/config.yaml

# Install hls
RUN ghcup install hls

# Install global packages.
RUN cabal install haskell-dap ghci-dap haskell-debug-adapter hlint apply-refact retrie stylish-haskell hoogle ormolu liquidhaskell

# Generate hoogle db
RUN hoogle generate && stack hoogle

# Copy default GHCi config:
COPY ./.ghci /home/${USERNAME}

ENV DEBIAN_FRONTEND=dialog

ENTRYPOINT ["/bin/bash"]
