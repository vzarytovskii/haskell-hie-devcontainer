FROM nixos/nix

ARG GHC_VERSION=ghc881
ARG USERNAME=vscode
ARG USER_UID=2001
ARG USER_GID=$USER_UID

RUN apk add --no-cache --update coreutils ca-certificates
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable
RUN nix-channel --options http2 false --update

RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
RUN cachix use all-hies

RUN nix-env -iA nixpkgs.haskell.compiler.$GHC_VERSION
RUN nix-env -iA nixpkgs.haskellPackages.cabal-install
RUN nix-env -iA nixpkgs.haskellPackages.liquidhaskell
RUN nix-env -iA nixpkgs.haskellPackages.liquidhaskell-cabal
RUN nix-env -iA nixpkgs.z3
RUN nix-env -iA unstableFallback.selection --arg selector "p: { inherit (p) $GHC_VERSION; }" -f https://github.com/infinisil/all-hies/tarball/master

COPY setup.sh /tmp/
RUN /bin/ash /tmp/setup.sh "$USERNAME" "$USER_UID" "$USER_GID"
RUN rm /tmp/setup.sh