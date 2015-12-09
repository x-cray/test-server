#!/bin/bash

set -e

VERSION="$CI_BRANCH-$CI_COMMIT-$CI_BUILD_NUMBER"
declare -A TARGETS=(
	[test-server]="."
)

# Set version in service.json
for i in "${!TARGETS[@]}"
do
	SERVICE=${TARGETS[$i]}/service.json
	TARGET=service-defs/${TARGETS[$i]}
	mkdir -p $TARGET
	echo "Setting version $VERSION for $SERVICE"
	sed "s/\$tag/$VERSION/g" $SERVICE > $TARGET/service-$CI_BRANCH.json
	cp $TARGET/service-$CI_BRANCH.json $TARGET/service-$VERSION.json
done
