#!/usr/bin/env bash
set -eux

# get add-apt-repository and curl
apt-get update
apt-get install -y software-properties-common curl less zip apt-transport-https libffi-dev clang

# add PL PPAs
add-apt-repository ppa:ansible/ansible
add-apt-repository ppa:nginx/stable
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:linuxuprising/java

# https://github.com/ponylang/ponyc/blob/master/README.md#installation
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E04F0923 B3B48BDA
add-apt-repository "deb https://dl.bintray.com/pony-language/ponylang-debian  $(lsb_release -cs) main"

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# elixir
# https://elixir-lang.org/install.html
curl -sS https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -o erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb \
  && rm erlang-solutions_1.0_all.deb

# dotnet instructions modified from
# https://www.microsoft.com/net/learn/dotnet/hello-world-tutorial
curl -sS https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb \
  && rm packages-microsoft-prod.deb

apt-get update

# Auto-accept the java license. Oracle sucks.
# https://stackoverflow.com/a/19391042/42559
echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | debconf-set-selections

apt-get install -y git bash-completion make build-essential libssl-dev \
  zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm \
  libncurses5-dev libncursesw5-dev xz-utils tk-dev unzip \
  ansible \
  dotnet-sdk-2.2 \
  elixir \
  esl-erlang \
  nginx \
  oracle-java12-installer oracle-java12-set-default maven \
  php7.3 php7.3-mbstring \
  ponyc \
  runit \

# yarn is a special snowflake; we want to install it independent of debian's
# node, so we have to do this. cf: https://yarnpkg.com/en/docs/install#debian-stable
apt-get install -y --no-install-recommends yarn

# download and install go 1.11 to /usr/local/go
curl -sS https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz | tar -C /usr/local -xz

# install leiningen for clojure
curl -sSL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /usr/bin/lein && \
    chmod a+x /usr/bin/lein && \
    /usr/bin/lein

sudo apt-get -y install ponyc
