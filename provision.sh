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
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

apt-get update

# Current dev environments for:
#   * python 2.7
#   * python 3.6
#   * ruby 2.4
#   * golang 1.9
#   * node 1.9
#   * php 7.2
#   * java 8
#
# Also:
#   * ansible
#   * nginx
#   * runit
#   * yarn
#   * some basics for building packages
apt-get install -y git bash-completion make build-essential libssl-dev \
  zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget llvm \
  libncurses5-dev libncursesw5-dev xz-utils tk-dev unzip \
  ansible \
  golang-1.9-go \
  openjdk-8-jdk \
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

# Use pyenv to install python 3.6.4. The apt-based solutions I tried really stunk.
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="/home/vagrant/.pyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile
echo 'source ~/.bashrc"' >> ~/.bash_profile
