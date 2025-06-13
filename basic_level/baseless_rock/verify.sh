#!/bin/bash

YAML_FILE="rockcraft.yaml"

# Expected values
EXPECTED_BASE="bare"
EXPECTED_BUILD_BASE="ubuntu@24.04"

# Check for yq dependency
if ! command -v yq &> /dev/null; then
    echo "'yq' is not installed. Please install it: https://github.com/mikefarah/yq"
    exit 1
fi

# Check if the base is set to 'bare'
check_base() {
    base_val=$(yq e '.base' "$YAML_FILE")
    if [[ "$base_val" == "$EXPECTED_BASE" ]]; then
        echo "Base is correctly set to 'bare'."
    else
        echo "Base is not set to 'bare'. Found: '$base_val'"
        return 1
    fi
}

# Check if build-base is set correctly
check_build_base() {
    build_base_val=$(yq e '.build-base' "$YAML_FILE")
    if [[ "$build_base_val" == "$EXPECTED_BUILD_BASE" ]]; then
        echo "Build-base is correctly set to 'ubuntu@24.04'."
    else
        echo "Build-base is not set to 'ubuntu@24.04'. Found: '$build_base_val'"
        return 1
    fi
}

# Run checks
echo "🔍 Verifying rockcraft.yaml for baseless configuration..."
check_base && check_build_base && {
    echo "rockcraft.yaml is correctly configured for a baseless rock!"
    exit 0
} || {
    echo "rockcraft.yaml is not properly configured."
    exit 1
}
