#!/bin/bash

# Define the service
service=systemd-journald

# Check the status of the service
echo "Checking the status of $service"
sudo systemctl status $service

# Stop the service
echo "Stopping $service"
sudo systemctl stop $service

# Start the service
echo "Starting $service"
sudo systemctl start $service

# Disable the service from starting on boot
echo "Disabling $service from starting on boot"
sudo systemctl disable $service

# Enable the service to start on boot
echo "Enabling $service to start on boot"
sudo systemctl enable $service

