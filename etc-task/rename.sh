#!/bin/sh

#set -e

echo "rename.sh called"

NEW_VERSION="$(cat version/number)"

echo "ARTIFACT_ID=$ARTIFACT_ID=VERSION=$VERSION=PACKAGING=$PACKAGING=NEW_VERSION=$NEW_VERSION="

cp pkg-out/$ARTIFACT_ID-$VERSION.$PACKAGING renamed-out/$ARTIFACT_ID-${NEW_VERSION}.$PACKAGING
