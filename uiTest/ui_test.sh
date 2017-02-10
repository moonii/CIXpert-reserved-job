#!/bin/bash

set -eux

_main() {
  echo $PWD
  echo [$(uname -a)]
  echo [$(id)]

  cd ui-git

  _install
  _unit_test
  _coverage

}

_install() {
  # node.js
  # curl -sL https://deb.nodesource.com/setup_4.x | bash -
  # apt-get install -y nodejs

  npm install
  npm install -g gulp
  npm install -g bower
  bower install --allow-root

}

_unit_test() {
  gulp test-admin
}


_coverage() {
  cd ..
  git clone coverage-git coverage-update

  cd coverage-update

  git config --global user.email "system@cixpert"
  git config --global user.name "cixpert"

  cp -r ../ui-git/coverage ./
  
  git add coverage
  git commit -m "coverage"

}

_main "$@"