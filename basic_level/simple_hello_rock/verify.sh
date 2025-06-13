#!/bin/bash

YAML_FILE="rockcraft.yaml"

# Expected values
EXPECTED_BASE="ubuntu@24.04"
EXPECTED_PLUGIN="nil"
EXPECTED_STAGE_PACKAGE="hello"

# Function to check if the base field is set correctly
check_base() {
    base_value=$(yq e '.base' "$YAML_FILE")
    if [[ "$base_value" == "$EXPECTED_BASE" ]]; then
        echo "Base field is correctly set to '$EXPECTED_BASE'."
    else
        echo "Base field is not correctly set. Found: '$base_value'"
        return 1
    fi
}

# Function to check if the parts.hello.plugin and stage-packages are correct
check_parts() {
    plugin=$(yq e '.parts.hello.plugin' "$YAML_FILE")
    package=$(yq e '.parts.hello.stage-packages[0]' "$YAML_FILE")

    local valid=true

    if [[ "$plugin" != "$EXPECTED_PLUGIN" ]]; then
        echo "Plugin is not correctly set. Found: '$plugin'"
        valid=false
    else
        echo "Plugin is correctly set to '$EXPECTED_PLUGIN'."
    fi

    if [[ "$package" != "$EXPECTED_STAGE_PACKAGE" ]]; then
        echo "Stage package is not correctly set. Found: '$package'"
        valid=false
    else
        echo "Stage package is correctly set to '$EXPECTED_STAGE_PACKAGE'."
    fi

    $valid || return 1
}

# Check if yq is installed
if ! command -v yq &> /dev/null; then
    echo "Error: 'yq' is required but not installed. Install it from https://github.com/mikefarah/yq"
    exit 1
fi

# Run checks
echo "Checking YAML file: $YAML_FILE"
check_base && check_parts && echo "All required fields are properly filled!" || {
    echo "Some fields are missing or incorrect."
    exit 1
}
