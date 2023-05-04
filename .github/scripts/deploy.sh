#!/bin/bash

function buildImage() {
    local dockerfile=$1
    local tagPrefix=$2
    local targetArch=$3
    local dryRun=$4

    local imageDir=${dockerfile//\Dockerfile/}
    local fullTag=$(echo "${dockerfile// /-}" | sed 's#\(.*\)/\(.*\)/image/Dockerfile#\1:\2#g; s#\(.*\)/image/Dockerfile#\1#g' | sed "s#./#$tagPrefix#" )
    local shortTag=$(echo "$fullTag" | awk -F'/' '{print $NF}')

    # Print info
    echo "Now generating image for $shortTag..."
    echo " -> Full tag:   $fullTag"
    echo " -> Dockerfile: $dockerfile"
    echo " -> Target: $targetArch"

    # Build image
    docker buildx build \
      --platform "$targetArch" \
      --tag "$fullTag" \
      "$imageDir";

    return 0
}

function buildDirectory() {
    local buildPath=$1
    local tagPrefix=$2
    local targetArch=$3

    find "$buildPath" -type f -name 'Dockerfile' -print0 |
    while IFS= read -r -d '' dockerfile;
    do
      buildImage "$dockerfile" "$tagPrefix" "$targetArch" "$dryRun"

      # Separate output
      echo ""
    done

    return 0
}

function pushDirectory() {
    local buildPath=$1
    local tagPrefix=$2

    # allow local testing
    if [[ $DRYRUN -eq 1 ]]; then
      return 0
    fi

    find "$buildPath" -type f -name 'Dockerfile' -print0 |
    while IFS= read -r -d '' dockerfile;
    do
      local fullTag=$(echo "${dockerfile// /-}" | sed 's#\(.*\)/\(.*\)/image/Dockerfile#\1:\2#g; s#\(.*\)/image/Dockerfile#\1#g' | sed "s#./#$tagPrefix#" )

      docker push "$fullTag"

      # Separate output
      echo ""
    done
}

function printSeparator() {
    echo "========================="
    echo "$1"
    echo "========================="
    echo ""
}


# Settings
#DRYRUN=1
TAG_PREFIX=ghcr.io/Team-Flashbang/Flashes
TARGET_PLATFORM=linux/arm64

# Exit when something fails
set -e

# Build base images first
buildDirectory "./base" "$TAG_PREFIX" "$TARGET_PLATFORM"
pushDirectory "./base" "$TAG_PREFIX"
printSeparator "All base images build."

# Build game images
buildDirectory "./games" "$TAG_PREFIX" "$TARGET_PLATFORM"
pushDirectory "./games" "$TAG_PREFIX"
printSeparator "All game images build."
