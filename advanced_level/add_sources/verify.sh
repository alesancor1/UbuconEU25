#!/bin/bash

set -e

cd /root/advanced_level

cleanup() {
    docker image rm -f "${ROCK_NAME}:latest" >/dev/null 2>&1 || true
}

# Ensure cleanup runs on script exit (success or failure)
trap cleanup EXIT

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

# Run container and verify the index.html content
docker run --rm "${ROCK_NAME}:latest" exec cat /index.html | grep -q "Hello World! From a Rock!"
