#!/bin/bash
set -euo pipefail

# ────────────────────────────────
# Paths
# ────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="${SCRIPT_DIR}/assets"
PARSER_FILE="${ASSETS_DIR}/parse_yaml.sh"
SHARED_FILE="${ASSETS_DIR}/shared.yaml"
SETUP_SCRIPT="${ASSETS_DIR}/linux.sh"

# ────────────────────────────────
# Require arguments
# ────────────────────────────────
if [[ $# -lt 2 ]]; then
  echo "Usage: $0 (--dry-run|--no-dry-run) (hypr|ml4w)"
  exit 1
fi

case "$1" in
  --dry-run) DRY_RUN=true ;;
  --no-dry-run) DRY_RUN=false ;;
  *)
    echo "Error: First argument must be --dry-run or --no-dry-run"
    exit 1
    ;;
esac

case "$2" in
  hypr|ml4w) DESKTOP="$2" ;;
  *)
    echo "Error: Second argument must be 'hypr' or 'ml4w'"
    exit 1
    ;;
esac

# ────────────────────────────────
# Verify required files
# ────────────────────────────────
for file in "$PARSER_FILE" "$SHARED_FILE" "$SETUP_SCRIPT"; do
  [[ -f "$file" ]] || { echo "Error: Missing required file: $file"; exit 1; }
done


# ────────────────────────────────
# Import parser
# ────────────────────────────────
source "$PARSER_FILE"

# ────────────────────────────────
# Parse shared + desktop YAMLs
# ────────────────────────────────
parse_yaml "$SHARED_FILE"
shared_pacpkg=("${pacpkg[@]}")
shared_aurpkg=("${aurpkg[@]}")

# Reset arrays
pacpkg=()
aurpkg=()

# Merge & deduplicate
pacpkg=($(printf "%s\n" "${shared_pacpkg[@]}" | sort -u))
aurpkg=($(printf "%s\n" "${shared_aurpkg[@]}" | sort -u))

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

echo
echo -e "${GREEN}✔ Dry run:${NC} $DRY_RUN"
echo -e "${GREEN}✔ Desktop:${NC} $DESKTOP"
echo -e "${GREEN}✔ Linux setup script:${NC} $SETUP_SCRIPT"
echo
echo -e "${GREEN}📦 Pacman packages:${NC}"
printf '  %s\n' "${pacpkg[@]}"
echo
echo -e "${GREEN}✨ AUR packages:${NC}"
printf '  %s\n' "${aurpkg[@]}"
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

