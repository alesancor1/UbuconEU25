#!/bin/bash

set -ex

# Build the rock
rockcraft pack > /var/log/verify.log 2>&1

# Find the generated rock file (assumes *_latest_amd64.rock)
ROCK_FILE=$(ls *.rock 2>/dev/null | head -n1)

# Extract rock name (before _latest_amd64)
ROCK_NAME=$(basename "$ROCK_FILE" | sed 's/_latest_amd64\.rock$//')

# Import the rock into Docker
rockcraft.skopeo --insecure-policy copy "oci-archive:${ROCK_FILE}" "docker-daemon:${ROCK_NAME}:latest"

# Run container and check the content
docker run --rm "${ROCK_NAME}:latest" exec cat /index.html | grep -q "Hello World! From a Rock!"