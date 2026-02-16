#!/usr/bin/env bash
set -euo pipefail

REPO="mova-compact/mova-downloads"
INSTALL_DIR="/usr/local/bin"

# Detect platform
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$OS" in
  linux*)
    PLATFORM="linux"
    ASSET="mova-compact-linux"
    ;;
  darwin*)
    PLATFORM="macos"
    ASSET="mova-compact-macos"
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac
URL="https://github.com/${REPO}/releases/latest/download/${ASSET}"

echo "Downloading MOVA Compact for ${PLATFORM}..."
TMP="$(mktemp -d)"
curl -fsSL "$URL" -o "${TMP}/${ASSET}"

chmod +x "${TMP}/${ASSET}"

echo "Installing to ${INSTALL_DIR}..."
sudo mv "${TMP}/${ASSET}" "${INSTALL_DIR}/mova-compact"
rm -rf "$TMP"

echo "Verifying..."
mova-compact -h
mova-compact collect -h

echo "MOVA Compact installed successfully."
