#!/bin/bash

# usage:
# * ./build.sh
# * must have a file called VERSION with the version number, e.g.
#   $ cat VERSION
#   0.1.2

set -e # exit if any command fails

image="flask-hello-world"

# list current docker images
docker images "$image"

read -r tag < VERSION
echo "Tag: $tag"
read -p "confirm correct tag (y): " confirm

if [ $confirm != "y" ]; then
    echo "User did not confirm tag, exiting..."
    exit 1
fi

docker buildx build --load --platform linux/amd64 -t "$image:$tag" .
