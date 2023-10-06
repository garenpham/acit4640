#!/bin/bash

# Create a subdirectory 'subdir' and copy this script there
mkdir -p subdir
cp $0 subdir/

# Change the permissions and ownership of a file so that it is owned by root, readable by everyone, and executable by root.
sudo chown root:root $0
sudo chmod 744 $0

# Elevate the user permissions to those of root user for a single invocation of the tree / command.
sudo tree /

