#!/bin/sh

#set -e

echo "rename.sh called"

NEW_VERSION="$(cat version/number)"

echo "ARTIFACT_ID=$ARTIFACT_ID=VERSION=$VERSION=PACKAGING=$PACKAGING=NEW_VERSION=$NEW_VERSION="

ls pkg-out/target/

cp pkg-out/target/$ARTIFACT_ID-$VERSION.$PACKAGING renamed-out/$ARTIFACT_ID-${NEW_VERSION}.$PACKAGING

ls renamed-out/
