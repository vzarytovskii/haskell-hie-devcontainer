FROM debian:stable

ARG GHC_VERSION=8.10.7
ARG STACK_RESOLVER=lts-18.19
ARG STACK_VERSION=2.7.5
ARG CABAL_VERSION=3.6.2.0
ARG HLS_VERSION=1.6.1.0

ENV USERNAME=haskeller \
    USER_UID=2001 \
    USER_GID=2001 \
    DEBIAN_FRONTEND=noninteractive \
    GHC_VERSION=${GHC_VERSION} \
    STACK_RESOLVER=${STACK_RESOLVER} \
    STACK_VERSION=${STACK_VERSION} \
    CABAL_VERSION=${CABAL_VERSION} \
    HLS_VERSION=${HLS_VERSION}

RUN apt-get update
RUN apt-get install -y --no-install-recommends  \
    apt-utils \
    bash \
    build-essential \
    ca-certificates \
    curl \
    gcc \
    git \
    libffi-dev \
    libffi7 \
    libgmp-dev \
    libgmp10 \
    libicu-dev \
    libncurses-dev \
    libncurses5 \
    libtinfo5 \
    lsb-release \
    make \
    procps \
    sudo \
    xz-utils \
    z3 \
    zlib1g-dev

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

# Set the GHC version.
RUN ghcup install ghc ${GHC_VERSION} && ghcup set ghc ${GHC_VERSION}

# Install cabal-iinstall
RUN ghcup install cabal ${CABAL_VERSION} && ghcup set cabal ${CABAL_VERSION}

# Update Cabal.
RUN cabal update && cabal new-install cabal-install

# Configure cabal
RUN cabal user-config update -f && \
    sed -i 's/-- ghc-options:/ghc-options: -haddock/g' ~/.cabal/config

# Install stack
RUN ghcup install stack ${STACK_VERSION} && ghcup set stack ${STACK_VERSION}

# Set system-ghc, install-ghc and resolver for stack.
RUN ((stack ghc -- --version 2>/dev/null) || true) && \
    # Set global defaults for stack.
    stack config --system-ghc set system-ghc true --global && \
    stack config --system-ghc set install-ghc false --global && \
    stack config --system-ghc set resolver $STACK_RESOLVER

# Set global custom defaults for stack.
RUN printf "ghc-options:\n  \"\$everything\": -haddock\n" >> /home/${USERNAME}/.stack/config.yaml

# Install hls
RUN ghcup install hls ${HLS_VERSION} && ghcup set hls ${HLS_VERSION}

# Install global packages.
# Versions are pinned, since we don't want to accidentally break anything (by always installing latest).
RUN cabal install --haddock-hoogle \
    haskell-dap-0.0.15.0 \
    ghci-dap-0.0.17.0 \
    haskell-debug-adapter-0.0.35.0 \
    hlint-3.2.7 \
    apply-refact-0.9.3.0 \
    retrie-1.1.0.0 \
    stylish-haskell-0.13.0.0 \
    hoogle-5.0.18.3 \
    ormolu-0.1.3.1 \
    liquidhaskell-0.8.10.2

# Generate hoogle db
RUN hoogle generate && stack hoogle

ENV DEBIAN_FRONTEND=dialog

ENTRYPOINT ["/bin/bash"]
