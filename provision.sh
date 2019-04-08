set -eux

# get add-apt-repository and curl
apt-get update
apt-get install -y software-properties-common curl less zip apt-transport-https libffi-dev

# add PL PPAs
add-apt-repository ppa:ansible/ansible
add-apt-repository ppa:nginx/stable
add-apt-repository ppa:ondrej/php
add-apt-repository ppa:linuxuprising/java
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# elixir
# https://elixir-lang.org/install.html
curl -sS https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb -o erlang-solutions_1.0_all.deb \
  && dpkg -i erlang-solutions_1.0_all.deb

# dotnet instructions modified from
# https://www.microsoft.com/net/learn/dotnet/hello-world-tutorial
curl -sS https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb \
  && dpkg -i packages-microsoft-prod.deb
apt-get update

# Auto-accept the java license. Oracle sucks.
# https://stackoverflow.com/a/19391042/42559
echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-2 seen true | debconf-set-selections

# * Current dev environments for:
#   * clojure
#   * dotnet 2.2
#   * elixir 1.7.3
#   * erlang 21.0.5
#   * golang 1.12.1
#   * java 11
#   * node 11.13.0
#   * php 7.2
#   * python 2.7.16
#   * python 3.7.3
#   * ruby 2.6.2
#   * rust 1.32.0
#
# * Also:
#   * ansible
#   * bundler
#   * maven
#   * nginx
#   * pyenv
#   * runit
#   * yarn
#   * some basics for building packages
apt-get install -y git bash-completion make build-essential libssl-dev \
  zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm \
  libncurses5-dev libncursesw5-dev xz-utils tk-dev unzip \
  ansible \
  dotnet-sdk-2.2 \
  elixir \
  esl-erlang \
  oracle-java11-installer oracle-java11-set-default maven \
  nginx \
  php7.3 php7.3-mbstring \
  runit

# yarn is a special snowflake; we want to install it independent of debian's
# node, so we have to do this. cf: https://yarnpkg.com/en/docs/install#debian-stable
apt-get install -y --no-install-recommends yarn

# download and install go 1.11 to /usr/local/go
curl -sS https://dl.google.com/go/go1.12.1.linux-amd64.tar.gz | tar -C /usr/local -xz

# install leiningen for clojure
curl -sSL https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -o /usr/bin/lein && \
    chmod a+x /usr/bin/lein && \
    /usr/bin/lein
