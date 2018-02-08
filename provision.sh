set -eux

# get add-apt-repository and curl
apt-get update
apt-get install -y software-properties-common curl

# add PL PPAs
add-apt-repository ppa:ansible/ansible
add-apt-repository ppa:brightbox/ruby-ng
add-apt-repository ppa:gophers/archive
add-apt-repository ppa:nginx/stable
add-apt-repository ppa:ondrej/php
curl -sL https://deb.nodesource.com/setup_9.x | bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# dotnet instructions modified from
# https://www.microsoft.com/net/learn/get-started/linuxubuntu
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-artful-prod artful main" | tee /etc/apt/sources.list.d/dotnetdev.list
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'

apt-get update

# * Current dev environments for:
#   * dotnet 2.1.4
#   * golang 1.9
#   * java 8 (openjdk)
#   * node 1.9
#   * php 7.2
#   * python 2.7.14
#   * python 3.6.4
#   * ruby 2.5
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
  dotnet-sdk-2.1.4 \
  golang-1.9-go \
  openjdk-8-jdk maven \
  nodejs yarn \
  nginx \
  php7.2 php7.2-mbstring \
  ruby2.5 \
  runit

gem install bundler

# XXX: I use this as my GOPATH. Is there a better default to use?
mkdir -p ~/go
ln -sf /usr/lib/go-1.9/bin/gofmt /usr/bin/
ln -sf /usr/lib/go-1.9/bin/go /usr/bin/
