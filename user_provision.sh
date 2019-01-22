# Everything in this file is run as the vagrant user, while the `provision.sh` script
# is run as superuser

# virtualenv-init depends on using unset variables, so you cannot use -u
set -ex

# Create GOPATH and add GO root and ~/go/bin to the $PATH for ease of using `go get ...`
mkdir -p ~/go
echo 'export GOPATH="$HOME/go"' >> ~/.bash_profile
echo 'export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"' >> ~/.bash_profile

# Use pyenv to install python 3.6.4. The apt-based solutions I tried really stunk.
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bash_profile

# install nodenv and a current node
# nodenv-installer requires you to put these on the path before it runs:
# https://github.com/nodenv/nodenv-installer/issues/8
export PATH="$HOME/.nodenv/bin:$HOME/.nodenv/shims:$PATH"
curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-installer | bash
echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(nodenv init -)"' >> ~/.bash_profile

# Once done installing the *envs, fix up the bash_profile and source it
echo 'source ~/.bashrc' >> ~/.bash_profile
source ~/.bash_profile

# then finally install some versions
pyenv install 3.7.2
pyenv install 2.7.15
nodenv install 11.6.0

pyenv global 3.7.2
nodenv global 11.6.0

# Install rustup and cargo with defaults. `-y` to disable confirmation prompt
curl https://sh.rustup.rs -sSf | sh -s -- -y
