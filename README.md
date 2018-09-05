# Custom/Cached binaries for heroku-buildpack-ruby

This repository contains custom binary packages for Ruby as a temporary solution
to work around current issues with pkgr and heroku-buildpack-ruby.

Use of anything from this repository is at your own risk. Ownership and/or
license of the binaries belong to their respective authors.

## Cache New Versions

New cached binary packages can be added via make targets.

Requirements:

- make
- curl
- shasum
- gpg, with a default private key available for signing.

### Ruby

To cache Ruby version 2.5.1:

    make ruby-2.5.1

This will produce eight new files:

- el-7/ruby-2.5.1.md
- el-7/ruby-2.5.1.tgz
- el-7/ruby-2.5.1.tgz.sha512
- el-7/ruby-2.5.1.tgz.sha512.gpg
- ubuntu-12.04/ruby-2.5.1.md
- ubuntu-12.04/ruby-2.5.1.tgz
- ubuntu-12.04/ruby-2.5.1.tgz.sha512
- ubuntu-12.04/ruby-2.5.1.tgz.sha512.gpg

### Bundler

To cache Bundler version 1.15.1:

    make bundler-1.15.1

### libYAML

To cache Bundler version 1.15.1:

    make libyaml-0.1.7
