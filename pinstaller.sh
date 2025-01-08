#!/bin/bash

# pinstaller.sh: A script to manage software installations

# Check if the script is run with sudo
if [[ "$EUID" -ne 0 ]]; then
  echo "Please run this script with sudo."
  exit 1
fi

# First-time installation check
if [ ! -f /etc/pinstaller_installed ]; then
  # Install Flatpak, Snap, and other dependencies for first-time setup
  echo "First-time installation. Installing necessary dependencies..."

  # Update package lists
  echo "Updating package lists..."
  sudo apt update -y

  # Install Snap and Flatpak
  echo "Installing Snap..."
  sudo apt install -y snapd

  echo "Installing Flatpak..."
  sudo apt install -y flatpak

  # Mark the first-time installation as complete
  touch /etc/pinstaller_installed
  echo "Dependencies installed. You can now use pinstaller."

  # Exit after first-time installation setup
  exit 0
fi

# Ensure the 'dialog' utility is installed
echo "Checking for 'dialog' utility..."
if ! command -v dialog > /dev/null 2>&1; then
  echo "'dialog' is not installed. Installing it now..."
  if sudo apt install -y dialog; then
    echo "'dialog' installed successfully."
  else
    echo "Failed to install 'dialog'. Please check your system and try again."
    exit 1
  fi
else
  echo "'dialog' is already installed."
fi

# Function to run the program's installation script
run_install_script() {
  local program=$1
  local manager=$2

  # Check if the script exists for the selected program and package manager
  if [ -f "installers/$program/$manager/install.sh" ]; then
    # Run the installation script
    bash "installers/$program/$manager/install.sh"
  else
    echo "Installation script for $program with $manager not found."
    exit 1
  fi
}

# Display a menu with a list of programs
program=$(dialog --clear --title "Program Installer" \
  --menu "Select a program to install:" 15 50 5 \
  1 "Firefox" \
  2 "Docker" \
  3 "GNOME Tweaks" \
  4 "VLC Media Player" \
  5 "Visual Studio Code" \
  2>&1 >/dev/tty)

# Check if the user clicked cancel (exit code 1)
if [ $? -ne 0 ]; then
  echo "No program selected. Exiting..."
  exit 0
fi

clear  # Clear the dialog screen

# Display a menu for the package manager selection
manager=$(dialog --clear --title "Select Package Manager" \
  --menu "Choose a package manager for $program:" 15 50 5 \
  1 "APT" \
  2 "Snap" \
  3 "Flatpak" \
  2>&1 >/dev/tty)

# Check if the user clicked cancel (exit code 1)
if [ $? -ne 0 ]; then
  echo "No package manager selected. Exiting..."
  exit 0
fi

clear  # Clear the dialog screen

# Map program selection to corresponding program name
case $program in
  1)
    program="firefox"
    ;;
  2)
    program="docker"
    ;;
  3)
    program="gnome-tweaks"
    ;;
  4)
    program="vlc"
    ;;
  5)
    program="vscode"
    ;;
  *)
    echo "No valid program selected."
    exit 1
    ;;
esac

# Map manager selection to corresponding package manager
case $manager in
  1)
    manager="apt"
    ;;
  2)
    manager="snap"
    ;;
  3)
    manager="flatpak"
    ;;
  *)
    echo "No valid package manager selected."
    exit 1
    ;;
esac

# Run the installation script
run_install_script "$program" "$manager"

exit 0