#!/bin/bash
set -euo pipefail

# ────────────────────────────────
# Paths
# ────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="${SCRIPT_DIR}/assets"
SETUP_SCRIPT="${ASSETS_DIR}/linux.sh"

# ────────────────────────────────
# Network check
# ────────────────────────────────
if ! ping -c 1 1.1.1.1 &>/dev/null; then
  echo "Error: No network connection detected."
  exit 1
fi

# ────────────────────────────────
# Display summary
# ────────────────────────────────
GREEN='\033[0;32m'
NC='\033[0m'
YELLOW='\033[00;33m'

echo
echo -e "${GREEN}Linux setup script:${NC} $SETUP_SCRIPT"
echo

# ────────────────────────────────
# Confirmation before continuing
# ────────────────────────────────
read -rp "Proceed with setup? (y/N): " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Setup aborted."
  exit 0
fi

# ────────────────────────────────
# Hand off to linux.sh
# ────────────────────────────────
source "$SETUP_SCRIPT"
