#!/bin/bash

# firefox.sh: Installation script for Firefox

# Check if Firefox is already installed
if command -v firefox > /dev/null 2>&1; then
  echo "Firefox is already installed."
else
  echo "Installing Firefox..."

  # Install Firefox using Flatpak
  flatpak install -y flathub org.mozilla.Firefox

  # Test Firefox installation
  flatpak run org.mozilla.Firefox

  echo "Firefox installation completed."
fi
