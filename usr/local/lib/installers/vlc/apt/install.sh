#!/bin/bash

# vlc.sh: Installation script for VLC Media Player

# Check if VLC is already installed
if command -v vlc > /dev/null 2>&1; then
  echo "VLC Media Player is already installed."
else
  echo "Installing VLC Media Player..."

  # Update package lists
  sudo apt update -y

  # Install VLC
  sudo apt install -y vlc

  # Test VLC installation
  vlc --version

  echo "VLC Media Player installation completed."
fi
