#!/bin/bash

set -ex

# cd to the correct path
cd /root/advanced_level

# Check that rock has been packed
ROCK_FILE=$(ls *.rock 2>/dev/null | head -n1)

if [ -z "$ROCK_FILE" ]; then
    echo "No .rock file found in /root/advanced_level"
    exit 1
fi

# Extract rock name (before _latest_amd64)
ROCK_NAME=$(basename "$ROCK_FILE" | sed 's/_latest_amd64\.rock$//')

# Import the rock into Docker
/snap/bin/rockcraft.skopeo --insecure-policy copy "oci-archive:${ROCK_FILE}" "docker-daemon:${ROCK_NAME}:latest"

# Run container and check the content
docker run --rm "${ROCK_NAME}:latest" exec cat /index.html | grep -q "Hello World! From a Rock!"