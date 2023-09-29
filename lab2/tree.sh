#!/bin/bash

# Install the tree package
# Note: This command needs to be run as root or with sudo privileges
sudo apt-get update
sudo apt-get install tree

# Check if the tree package is installed
if dpkg -l | grep -q "^ii  tree "; then
    echo "The tree package is installed."
else
    echo "The tree package is not installed."
fi

