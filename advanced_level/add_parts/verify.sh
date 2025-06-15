#!/bin/bash

set -e

cd /root/advanced_level

cleanup() {
    docker stop test-nginx >/dev/null 2>&1 || true
    docker image rm -f "${ROCK_NAME}:latest" >/dev/null 2>&1 || true
}

# Ensure cleanup runs on exit (success or failure)
trap cleanup EXIT

# Check that rock has been packed
ROCK_FILE=$(ls *.rock 2>/dev/null | head -n1)

if [ -z "$ROCK_FILE" ]; then
    echo "No .rock file found in /root/advanced_level"
    exit 1
fi

ROCK_NAME=$(basename "$ROCK_FILE" | sed 's/_latest_amd64\.rock$//')

# Import the rock into Docker
/snap/bin/rockcraft.skopeo --insecure-policy copy "oci-archive:${ROCK_FILE}" "docker-daemon:${ROCK_NAME}:latest"

# Run the container
docker run --rm -d -p 8123:80 -p 8124:443 --name test-nginx "${ROCK_NAME}:latest"

# Wait briefly for the service to start
sleep 2

# Run checks
curl -s http://localhost:8123 | grep "301 Moved Permanently"
curl -sk https://localhost:8124 | grep "Hello World! From a Rock!"
