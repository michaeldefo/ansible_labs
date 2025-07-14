#!/bin/bash

# -----------------------------------------------------------------------------
# Name: prj_versionning.sh
# Author: Michael D.
# Version: 0.0.1
# Description: This version is for Unix like system. It help generating versionning of project 
#              regarding the current version.
#Usage: ./version.sh major|minor|patch
# -----------------------------------------------------------------------------

set -e

if [ ! -f VERSION ]; then
  echo "0.0.0" > VERSION
fi

VERSION=$(cat VERSION)
IFS='.' read -r -a parts <<< "$VERSION"

case "$1" in
  major)
    parts[0]=$((parts[0]+1)); parts[1]=0; parts[2]=0 ;;
  minor)
    parts[1]=$((parts[1]+1)); parts[2]=0 ;;
  patch)
    parts[2]=$((parts[2]+1)) ;;
  *)
    echo "Usage: $0 {major|minor|patch}"; exit 1 ;;
esac

NEW_VERSION="${parts[0]}.${parts[1]}.${parts[2]}"
echo "$NEW_VERSION" > VERSION
echo "Version bumped to $NEW_VERSION"
