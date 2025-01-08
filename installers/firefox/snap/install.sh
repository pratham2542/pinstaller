#!/bin/bash

# firefox.sh: Installation script for Firefox

# Check if Firefox is already installed
if command -v firefox > /dev/null 2>&1; then
  echo "Firefox is already installed."
else
  echo "Installing Firefox..."

  # Install Firefox using Snap
  sudo snap install firefox

  # Test Firefox installation
  firefox --version

  echo "Firefox installation completed."
fi