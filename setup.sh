#!/bin/bash
set -euo pipefail

# import assets
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Paths to assets
ASSETS_DIR="${SCRIPT_DIR}/assets"
PARSER_FILE="${ASSETS_DIR}/parse_yaml.sh"
YAML_FILE="${ASSETS_DIR}/packages.yaml"

if [[ "$(uname)" == "Darwin" ]]; then
    SETUP_SCRIPT="${ASSETS_DIR}/macos.sh"
elif [[ "$(uname -n)" == "Li" ]]; then
    SETUP_SCRIPT="${ASSETS_DIR}/linux.sh"
fi

DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
  DRY_RUN=true
fi

# Source the parser function
if [[ -f "$PARSER_FILE" ]]; then
  source "$PARSER_FILE"
else
  echo "Error: Parser file not found at $PARSER_FILE" >&2
  exit 1
fi

# Check YAML file
if [[ ! -f "$YAML_FILE" ]]; then
  echo "Error: YAML file not found at $YAML_FILE" >&2
  exit 1
fi

# Parse YAML
parse_yaml "$YAML_FILE"

if ! ping -c 1 1.1.1.1 &>/dev/null; then
  echo "Error: No network connection detected. Please connect first."
  exit 1
fi


# Colors
GREEN='\033[0;32m'
NC='\033[0m'

source SETUP_SCRIPT
