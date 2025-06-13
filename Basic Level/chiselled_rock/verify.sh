#!/bin/bash

YAML_FILE="rockcraft.yaml"

# Check for yq
if ! command -v yq &> /dev/null; then
    echo "❌ 'yq' is not installed. Please install it: https://github.com/mikefarah/yq"
    exit 1
fi

# Check for 'hello_bins'
if ! yq e '.. | scalars' "$YAML_FILE" | grep -q '^hello_bins$'; then
    echo "❌ 'hello_bins' not found in rockcraft.yaml."
    exit 1
fi

# Ensure 'hello' is not present (excluding hello_bins)
if yq e '.. | scalars' "$YAML_FILE" | grep -q '^hello$'; then
    echo "❌ 'hello' is still present in rockcraft.yaml. It should be removed."
    exit 1
fi

echo "✅ 'hello' has been successfully replaced with 'hello_bins'."
exit 0
