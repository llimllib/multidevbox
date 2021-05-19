#!/usr/bin/env bash
set -eux

# get add-apt-repository and curl
apt-get update
apt-get install -y software-properties-common curl less zip apt-transport-https ca-certificates

# add PL PPAs
add-apt-repository ppa:ansible/ansible # ansible
add-apt-repository ppa:nginx/stable    # nginx
add-apt-repository ppa:ondrej/php      # php

curl -sSf https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# elixir
# https://elixir-lang.org/install.html
curl -sSf https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -o erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && rm erlang-solutions_1.0_all.deb

# dotnet instructions modified from
# https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#1804
curl -sSf https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb && \
  dpkg -i packages-microsoft-prod.deb && \
  rm packages-microsoft-prod.deb

apt-get update

apt-get install -y \
  aspnetcore-runtime-5.0 \
  bash-completion \
  build-essential \
  xz-utils \
  tk-dev \
  libffi-dev \
  ansible \
  clang \
  dotnet-sdk-2.2 \
  dotnet-sdk-3.1 \
  dotnet-sdk-5.0 \
  elixir \
  esl-erlang \
  git \
  gnat \
  libbz2-dev \
  liblzma-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  llvm \
  make \
  nginx \
  runit \
  unzip \
  wget \
  zlib1g-dev

# Need to install php with --no-recommends to prevent apache2 from being installed
apt-get install --no-install-recommends -y php7.3 php7.3-mbstring

# yarn is a special snowflake; we want to install it independent of debian's
# node, so we have to do this. cf: https://yarnpkg.com/en/docs/install#debian-stable
apt-get install -y --no-install-recommends yarn

# download and install go 1.14 to /usr/local/go
curl -sSf https://dl.google.com/go/go1.15.5.linux-amd64.tar.gz | tar -C /usr/local -xz

# install leiningen for clojure
curl -sSfL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /usr/bin/lein
chmod a+x /usr/bin/lein

# install docker
snap install docker
