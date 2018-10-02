# Everything in this file is run as the vagrant user, while the `provision.sh` script
# is run as superuser

# virtualenv-init depends on using unset variables, so you cannot use -u
set -ex

# Create GOPATH and add GO root and ~/go/bin to the $PATH for ease of using `go get ...`
mkdir -p ~/go
echo 'export GOPATH="/home/vagrant/go"' >> ~/.bash_profile
echo 'export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"' >> ~/.bash_profile

# Use pyenv to install python 3.6.4. The apt-based solutions I tried really stunk.
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="/home/vagrant/.pyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile
echo 'source ~/.bashrc' >> ~/.bash_profile

# now bring pyenv into the current shell session so we can install us some pythons
source ~/.bash_profile
pyenv install 3.7.0
pyenv install 2.7.14

# Install rustup and cargo with defaults. `-y` to disable confirmation prompt
curl https://sh.rustup.rs -sSf | sh -s -- -y
