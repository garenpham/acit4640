#!/bin/bash

# Source the state file
source state_file_ec2.txt

# Find EC2 Public IPv4 DNS
REMOTE_HOST=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PublicDnsName' --output text)
REMOTE_HOST_IP=$(aws ec2 describe-instances --instance-ids $instance_id --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

REMOTE_USER=ubuntu
SSH_KEY_FILE=~/.ssh/acit_4640


scp -i $SSH_KEY_FILE -r setup $REMOTE_USER@$REMOTE_HOST:~/setup

# Create a user called a01 with the home folder /a01

ssh $REMOTE_HOST << EOF
  sudo su

  # Create a user called a01 with the home folder /a01
  useradd -m -d /a01 a01

  # Install nginx
  apt update && apt install -y nginx

  chmod 755 /a01

  # Copy the frontend file index.html to /a01/web_root
  mkdir /a01/web_root ; cp /home/ubuntu/setup/frontend/index.html /a01/web_root

  # Copy the backend to /a01/app
  mkdir /a01/app ; cp /home/ubuntu/setup/backend/* /a01/app

  # Copy nginx default file 
  cp /home/ubuntu/setup/default /etc/nginx/sites-available/default && systemctl restart nginx

  systemctl status nginx
EOF