#!/bin/bash

set -e

echo "rename-release-exe.sh called"

VERSION="$(cat source-git/version)"

echo "VERSION=$VERSION="

cp jar-file/PaasXpert-Portal-0.0.1.war renamed-out/PaasXpert-Portal-:${VERSION}.war
