#!/bin/bash

# gnome-tweaks.sh: Installation script for GNOME Tweaks

# Check if GNOME Tweaks is already installed
if command -v gnome-tweaks > /dev/null 2>&1; then
  echo "GNOME Tweaks is already installed."
else
  echo "Installing GNOME Tweaks..."

  # Update package lists
  sudo apt update -y

  # Install GNOME Tweaks
  sudo apt install -y gnome-tweaks

  # Test GNOME Tweaks installation
  gnome-tweaks --version

  echo "GNOME Tweaks installation completed."
fi
