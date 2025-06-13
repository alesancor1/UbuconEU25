#!/bin/bash

YAML_FILE="rockcraft.yaml"

# Check for yq
if ! command -v yq &> /dev/null; then
    echo "'yq' is not installed. Please install it: https://github.com/mikefarah/yq"
    exit 1
fi

# Check if parts.hello.stage-packages contains 'hello_bins'
if ! yq e '.parts.hello["stage-packages"][]' "$YAML_FILE" | grep -qx 'hello_bins'; then
    echo "'hello_bins' not found in parts.hello.stage-packages."
    exit 1
fi

# Ensure 'hello' is not present in parts.hello.stage-packages
if yq e '.parts.hello["stage-packages"][]' "$YAML_FILE" | grep -qx 'hello'; then
    echo "'hello' is still present in parts.hello.stage-packages. It should be removed."
    exit 1
fi

echo "Correct: 'hello_bins' is present and 'hello' is removed in stage-packages."
exit 0
