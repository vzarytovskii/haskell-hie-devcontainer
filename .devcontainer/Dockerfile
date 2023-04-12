FROM debian:bullseye-slim as base

ENV LANG C.UTF-8

ARG GHC_VERSION=9.4.4
ARG STACK_VERSION=recommended
ARG STACK_RESOLVER=default
ARG CABAL_VERSION=recommended
ARG HLS_VERSION=recommended
ARG LLVM_VERSION=14

ENV USERNAME=vscode \
    USER_UID=1000 \
    USER_GID=1000 \
    DEBIAN_FRONTEND=noninteractive \
    GHC_VERSION=${GHC_VERSION} \
    STACK_VERSION=${STACK_VERSION} \
    STACK_RESOLVER=${STACK_RESOLVER} \
    CABAL_VERSION=${CABAL_VERSION} \
    HLS_VERSION=${HLS_VERSION} \
    LLVM_VERSION=${LLVM_VERSION}

RUN ulimit -n 8192

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils bash build-essential ca-certificates curl gcc git gnupg libffi-dev libffi7 libgmp-dev libgmp-dev libgmp10 libicu-dev libncurses-dev libncurses5 libnuma1 libnuma-dev libtinfo5 lsb-release make procps software-properties-common sudo wget xz-utils z3 zlib1g-dev

RUN wget -O /tmp/llvm.sh https://apt.llvm.org/llvm.sh && chmod +x /tmp/llvm.sh && /tmp/llvm.sh ${LLVM_VERSION} && rm /tmp/llvm.sh

RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd -ms /bin/bash -K MAIL_DIR=/dev/null --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} && \
    echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME}

USER ${USER_UID}:${USER_GID}
WORKDIR /home/${USERNAME}
ENV PATH="/home/${USERNAME}/.local/bin:/home/${USERNAME}/.cabal/bin:/home/${USERNAME}/.ghcup/bin:$PATH"

RUN echo "export PATH=${PATH}" >> /home/${USERNAME}/.profile

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=yes \
    BOOTSTRAP_HASKELL_NO_UPGRADE=yes

FROM base as tooling

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

# Set the GHC version.
RUN ghcup install ghc ${GHC_VERSION} --set

# Install cabal-iinstall
RUN ghcup install cabal ${CABAL_VERSION} --set

# Update Cabal.
RUN cabal update && cabal new-install cabal-install

# Configure cabal
RUN cabal user-config update -f && \
    sed -i 's/-- ghc-options:/ghc-options: -haddock/g' ~/.cabal/config

# Install stack
RUN ghcup install stack ${STACK_VERSION} --set

# Set system-ghc, install-ghc and resolver for stack.
RUN ((stack ghc -- --version 2>/dev/null) || true) && \
    # Set global defaults for stack.
    stack config --system-ghc set system-ghc true --global && \
    stack config --system-ghc set install-ghc false --global && \
    test "${STACK_RESOLVER}" = 'default' && export STACK_RESOLVER=$(stack ls snapshots remote | grep -B1 "\(ghc-${GHC_VERSION}\)" | head -2 | sed -n -e 's/^Resolver name: \(\S\+\)$/\1/p'); \
    stack config --system-ghc set resolver ${STACK_RESOLVER}

# Set global custom defaults for stack.
RUN printf "ghc-options:\n  \"\$everything\": -haddock\n" >> /home/${USERNAME}/.stack/config.yaml

# Install hls
RUN ghcup install hls ${HLS_VERSION} --set

FROM tooling as packages

# Install global packages.
# Versions are pinned, since we don't want to accidentally break anything (by always installing latest).
RUN cabal install --haddock-hoogle \
#    fsnotify-0.3.0.1 \
    haskell-dap-0.0.16.0 \
    ghci-dap-0.0.20.0 \
    haskell-debug-adapter-0.0.39.0 \
    hlint-3.5 \
    apply-refact-0.11.0.0 \
    retrie-1.2.1.1 \
    hoogle-5.0.18.3 \
    ormolu-0.5.2.0

#FROM packages as hoogle

# Generate hoogle db
#RUN hoogle generate && stack hoogle

ENV DEBIAN_FRONTEND=dialog

ENTRYPOINT ["/bin/bash"]
