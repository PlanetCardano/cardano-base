FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install curl git bzip2

RUN useradd -ms /bin/bash cardano

RUN mkdir /nix && chown cardano /nix
RUN mkdir -p /etc/nix
RUN echo 'binary-caches            = https://cache.nixos.org https://hydra.iohk.io' > /etc/nix/nix.conf
RUN echo 'binary-cache-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=' >> /etc/nix/nix.conf
RUN echo 'trusted-substituters = https://cache.nixos.org https://hydra.iohk.io' >> /etc/nix/nix.conf
RUN echo 'trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=' >> /etc/nix/nix.conf

USER cardano
ENV USER cardano
RUN curl https://nixos.org/nix/install | sh

WORKDIR /home/cardano
RUN git clone https://github.com/input-output-hk/cardano-sl.git
WORKDIR cardano-sl
RUN git checkout debc5a846cda872fcdc3e21a0d893672c1bb109c #April 30, 2018. API v1 beta.

