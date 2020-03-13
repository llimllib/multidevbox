# MultiDevBox

I often find myself having to run random untrusted snippets of code, so this is
a box that gathers together a bunch of reasonably up-to-date common development
environments.

## How to use it

* install [Vagrant](https://www.vagrantup.com/)
* Create a file called `Vagrantfile` with these contents:

```
Vagrant.configure("2") do |config|
  # https://github.com/llimllib/multidevbox
  config.vm.box = "llimllib/multidev"
end
```

* run `vagrant up`
* run `vagrant ssh` to ssh into your newly created box. That's it!

## Prerequisites for building the image

You don't need to to do this just to use it! See above.

* GNU make
* wget
* packer
* virtualbox

## How to run

1. Go into the `envimation` directory and run `make download` to download the
   [base box](https://app.vagrantup.com/envimation/boxes/ubuntu-xenial)
2. In the root directory, run `make package` to use packer to build the box.

## What it's got:

* Current dev environments for:
  * dotnet 2.2
  * elixir 1.7.3
  * erlang 21.0.5
  * golang 1.12.1
  * java 11.0.2 (openjdk)
  * java 12.0.2 (openjdk)
  * java 13.0.1 (openjdk)
  * node 12.7.0
  * php 7.3
  * python 2.7.16
  * python 3.8.2
  * ruby 2.6.3
  * rust 1.33.0

* Also:
  * ansible
  * bundler
  * cargo
  * jenv
  * leiningen
  * maven
  * nginx
  * pipenv
  * pyenv
  * runit
  * rustup
  * yarn
  * some basics for building packages

## Contributors

* [@rdimartino](https://github.com/rdimartino)
