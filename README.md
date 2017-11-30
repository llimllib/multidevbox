# MultiDevBox

I often find myself having to run random untrusted snippets of code, so this is
a box that gathers together a bunch of reasonably up-to-date common development
environments.

## Prerequisites

* GNU make
* wget
* packer
* virtualbox

## How to run

1. Go into the `envimation` directory and run `make download` to download the
   [base box](https://app.vagrantup.com/envimation/boxes/ubuntu-xenial)
2. In the root directory, run `make package` to use packer to build the box.
