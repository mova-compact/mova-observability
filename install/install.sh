#!/usr/bin/env bash
set -euo pipefail

REPO="mova-compact/mova-compact"
INSTALL_DIR="/usr/local/bin"

# Detect platform
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$OS" in
  linux*)  PLATFORM="linux" ;;
  darwin*) PLATFORM="macos" ;;
  *)       echo "Unsupported OS: $OS"; exit 1 ;;
esac

ASSET="mova-compact-${PLATFORM}.zip"
URL="https://github.com/${REPO}/releases/latest/download/${ASSET}"

echo "Downloading MOVA Compact for ${PLATFORM}..."
TMP="$(mktemp -d)"
curl -fsSL "$URL" -o "${TMP}/${ASSET}"

echo "Extracting..."
unzip -q "${TMP}/${ASSET}" -d "${TMP}"
chmod +x "${TMP}/mova-compact"

echo "Installing to ${INSTALL_DIR}..."
sudo mv "${TMP}/mova-compact" "${INSTALL_DIR}/mova-compact"
rm -rf "$TMP"

echo "Verifying..."
mova-compact --version

echo "MOVA Compact installed successfully."
