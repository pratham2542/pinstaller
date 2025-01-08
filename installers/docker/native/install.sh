#!/bin/bash

# docker.sh: Installation script for Docker

# Check if Docker is already installed
if command -v docker > /dev/null 2>&1; then
  echo "Docker is already installed."
else
  echo "Installing Docker..."

  # Update and install required packages
  sudo apt update -y
  sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

  # Add Docker's official GPG key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  # Set up the Docker repository
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

  # Install Docker
  sudo apt update -y
  sudo apt install -y docker-ce docker-ce-cli containerd.io

  # Test Docker installation
  sudo docker --version

  echo "Docker installation completed."
fi
