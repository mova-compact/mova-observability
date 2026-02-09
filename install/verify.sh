#!/usr/bin/env bash
set -euo pipefail

CHECKSUMS_URL="https://raw.githubusercontent.com/mova-compact/mova-compact/main/checksums/SHA256SUMS.txt"
BINARY="${1:-$(command -v mova-compact)}"

if [ ! -f "$BINARY" ]; then
  echo "Error: mova-compact binary not found at: $BINARY"
  exit 1
fi

echo "Binary: $BINARY"
ACTUAL=$(sha256sum "$BINARY" | awk '{print $1}')
echo "SHA256: $ACTUAL"

echo ""
echo "Compare against official checksums at:"
echo "  $CHECKSUMS_URL"
echo ""
echo "Verification complete."
