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

## What it's got:

* Current dev environments for:
  * python 2.7
  * python 3.6
  * ruby 2.4
  * golang 1.9
  * node 1.9
  * php 7.2
  * java 8

* Also:
  * ansible
  * nginx
  * runit
  * some basics for building packages
