#!/bin/bash

#set -e

echo "rename-release-exe.sh called"

#VERSION="$(cat version/number)"
VERSION="1.0.0.rc"
echo "VERSION=$VERSION="

cp pkg-out/PaasXpert-Portal-0.0.1.war renamed-out/PaasXpert-Portal-${VERSION}.war