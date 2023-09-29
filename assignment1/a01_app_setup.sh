#!/bin/bash

# Source the state file
source state_file_ec2.txt

# Find EC2 Ip Address
ip_address=$(aws ec2 describe-instances --instance-ids “$instance_id” --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)