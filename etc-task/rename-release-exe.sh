#!/bin/bash

set -e

VERSION="$(cat version/version)"
echo "VERSION=$VERSION="

cp jar-file/PaasXpert-Portal-0.0.1.war renamed-out/PaasXpert-Portal-:${VERSION}.war
