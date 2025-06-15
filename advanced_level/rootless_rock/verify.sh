#!/bin/bash

set -e

cd /root/advanced_level

# Define cleanup logic
cleanup() {
    docker stop test-nginx >/dev/null 2>&1 || true
    docker image rm -f "${ROCK_NAME}:latest" >/dev/null 2>&1 || true
}

# Ensure cleanup always runs
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

# Run container in background
docker run --rm -d -p 8123:80 --name test-nginx "${ROCK_NAME}:latest"

# Give NGINX time to start
sleep 2

# Verify the content
curl http://localhost:8123 | grep "Hello World! From a Rock!"
