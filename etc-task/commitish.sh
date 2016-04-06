#!/bin/sh

#set -e

echo "committish.sh called"

git -C source-git/ rev-parse HEAD > generated-commitish/commitish

echo "VERSION=$VERSION="

cat generaged-commitish/commitish
