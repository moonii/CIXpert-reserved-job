#!/bin/sh

#set -e

echo "committish.sh called"

git -C source-git/ rev-parse HEAD > generated-commitish/commitish

ls generated-commitish/commitish
