#!/bin/bash

# vscode.sh: Installation script for Visual Studio Code

# Check if Visual Studio Code is already installed
if command -v code > /dev/null 2>&1; then
  echo "Visual Studio Code is already installed."
else
  echo "Installing Visual Studio Code..."

  # Update package lists
  sudo apt update -y

  # Install required dependencies for Visual Studio Code
  sudo apt install -y software-properties-common apt-transport-https curl

  # Add the Microsoft repository
  curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

  # Update package lists again to include the Microsoft repository
  sudo apt update -y

  # Install Visual Studio Code
  sudo apt install -y code

  # Test Visual Studio Code installation
  code --version

  echo "Visual Studio Code installation completed."
fi
