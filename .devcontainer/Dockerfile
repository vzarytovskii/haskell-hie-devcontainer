FROM nixos/nix

ENV GHC_VERSION=ghc865 \
    HIE_VERSION=master \
    STACK_RESOLVER=lts-14.27 \
    USERNAME=vscode \
    USER_UID=2001 \
    USER_GID=2001

RUN apk add --no-cache --update ca-certificates git openssh-client less bash libgcc libstdc++ curl procps coreutils krb5-libs libintl libssl1.1 lttng-ust tzdata userspace-rcu zlib shadow sudo

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable && \
    nix-channel --options http2 false --update && \
    nix-env -iA cachix -f https://cachix.org/api/v1/install && \
    cachix use all-hies && \
    nix-env -iA nixpkgs.haskell.compiler.$GHC_VERSION && \
    nix-env -iA nixpkgs.haskellPackages.cabal-install && \
    nix-env -iA nixpkgs.stack && \
    nix-env -iA nixpkgs.z3 && \
    nix-env -iA nixpkgs.haskellPackages.liquidhaskell && \
    nix-env -iA nixpkgs.haskellPackages.liquidhaskell-cabal && \
    nix-env -iA nixpkgs.haskellPackages.phoityne-vscode && \
    nix-env -iA nixpkgs.haskellPackages.haskell-dap && \
    nix-env -iA nixpkgs.haskellPackages.hlint && \
    nix-env -iA nixpkgs.haskellPackages.hindent && \
    nix-env -iA nixpkgs.haskellPackages.stylish-haskell && \
    nix-env -iA nixpkgs.haskellPackages.hoogle && \
    nix-env -iA nixpkgs.haskellPackages.pointfree && \
    nix-env -iA nixpkgs.haskellPackages.pointful && \
    nix-env -iA nixpkgs.haskellPackages.retrie && \
    nix-env -iA unstableFallback.selection --arg selector "p: { inherit (p) $GHC_VERSION; }" -f https://github.com/infinisil/all-hies/tarball/${HIE_VERSION}

# Do some cleanup
RUN nix-collect-garbage --delete-old && \
    nix-store --optimise && \
    nix-store --verify --check-contents

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd -s /bin/ash -K MAIL_DIR=/dev/null --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    usermod -a -G wheel ${USERNAME} && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME && \
    chmod a+rw /nix/var/nix/gcroots/per-user/

# To init global-project
RUN ((sudo -u $USERNAME -- stack ghc -- --version 2>/dev/null) || true) && \
    # Set global defaults for stack.
    sudo -u $USERNAME -- stack config --system-ghc set system-ghc --global true && \
    sudo -u $USERNAME -- stack config --system-ghc set install-ghc --global false && \
    sudo -u $USERNAME -- stack config --system-ghc set resolver $STACK_RESOLVER

ENTRYPOINT ["/bin/bash"]