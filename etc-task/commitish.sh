#!/bin/sh

#set -e

echo "committish.sh called 2"

git -C source-git/ rev-parse HEAD > generated-commitish/commitish

ls generated-commitish/commitish
