# Everything in this file is run as the vagrant user, while the `provision.sh` script
# is run as superuser. In the normal build process this is run by packer. It
# can also be run via the Vagrantfile with `vagrant provision`

# virtualenv-init depends on using unset variables, so you cannot use -u
set -ex

# Install jenv for switching between versions.
test -d ~/.jenv && rm -rf ~/.jenv
git clone https://github.com/jenv/jenv.git ~/.jenv
mkdir ~/.jenv/versions
echo 'export PATH="~/.jenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(jenv init -)"' >> ~/.bash_profile

function download_java {
    url="$1"
    filename=$(basename "$url")
    if [[ ! -e "$filename" ]]; then
        curl -O "$url"
        tar -xzf "$filename"
    fi
}

download_java "https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz"
download_java "https://download.java.net/java/GA/jdk12.0.2/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/openjdk-12.0.2_linux-x64_bin.tar.gz"
download_java "https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz"

# Create GOPATH and add GO root and ~/go/bin to the $PATH for ease of using `go get ...`
mkdir -p ~/go
echo 'export GOPATH="$HOME/go"' >> ~/.bash_profile
echo 'export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"' >> ~/.bash_profile

# Use pyenv to install python 3.6.4. The apt-based solutions I tried really stunk.
test -d ~/.pyenv && rm -rf ~/.pyenv
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="$HOME/.pyenv/bin:$HOME/.local/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile

# install nodenv and a current node
# nodenv-installer requires you to put these on the path before it runs:
# https://github.com/nodenv/nodenv-installer/issues/8
export PATH="$HOME/.nodenv/bin:$HOME/.nodenv/shims:$PATH"
test -d ~/.nodenv && rm -rf ~/.nodenv
curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-installer | bash
echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(nodenv init -)"' >> ~/.bash_profile

# install rbenv and a current ruby
# https://github.com/rbenv/rbenv-installer#rbenv-installer
# rbenv-installer requires you to put these on the path before it runs
# apparently too
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
test -d ~/.rbenv && rm -rf ~/.rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

# Once done installing the *envs, fix up the bash_profile and source it
echo 'source ~/.bashrc' >> ~/.bash_profile
source ~/.bash_profile

find . -wholename "**/bin/java" | \
    while read -r java_bin; do
        jdk_dir="${java_bin%*/bin/java}"
        jenv add "$jdk_dir"
    done
jenv global 13

# Now that java is installed, run lein to ensure it works.
lein

# then finally install some versions
pyenv install 3.8.2
pyenv install 2.7.16
nodenv install 12.7.0
rbenv install 2.6.3

pyenv global 3.8.2
pip3 install --user pipenv
nodenv global 12.7.0
rbenv global 2.6.3

# verify that ruby is installed properly and install bundler
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
gem install bundler

# Install rustup and cargo with defaults. `-y` to disable confirmation prompt
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install swift to ~/swift
mkdir ~/swift
curl https://swift.org/builds/swift-5.0.2-release/ubuntu1604/swift-5.0.2-RELEASE/swift-5.0.2-RELEASE-ubuntu16.04.tar.gz | tar xzv -C ~/swift --strip-components 2
echo 'export PATH=$PATH:$HOME/swift/bin' >> ~/.bash_profile
