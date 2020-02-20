FROM nixos/nix

ARG GHC_VERSION=ghc881
ARG USERNAME=vscode
ARG USER_UID=2001
ARG USER_GID=$USER_UID

RUN apk add --no-cache --update coreutils ca-certificates git openssh-client less bash libgcc libstdc++ curl procps coreutils krb5-libs libintl libssl1.1 lttng-ust tzdata userspace-rcu zlib shadow sudo

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable
RUN nix-channel --options http2 false --update

RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
RUN cachix use all-hies

RUN nix-env -iA nixpkgs.haskell.compiler.$GHC_VERSION
RUN nix-env -iA nixpkgs.haskellPackages.cabal-install
RUN nix-env -iA nixpkgs.stack
RUN nix-env -iA nixpkgs.z3
RUN nix-env -iA nixpkgs.haskellPackages.liquidhaskell
RUN nix-env -iA nixpkgs.haskellPackages.liquidhaskell-cabal
RUN nix-env -iA nixpkgs.haskellPackages.phoityne-vscode
RUN nix-env -iA nixpkgs.haskellPackages.haskell-dap
RUN nix-env -iA nixpkgs.haskellPackages.hlint

RUN nix-env -iA unstableFallback.selection --arg selector "p: { inherit (p) $GHC_VERSION; }" -f https://github.com/infinisil/all-hies/tarball/master

RUN groupadd --gid $USER_GID $USERNAME
RUN useradd -s /bin/ash -K MAIL_DIR=/dev/null --uid $USER_UID --gid $USER_GID -m $USERNAME
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
RUN chmod 0440 /etc/sudoers.d/$USERNAME