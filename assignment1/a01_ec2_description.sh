#!/bin/bash

# Source the state file
source state_file_ec2.txt

# Describe EC2 instance
aws ec2 describe-instances --instance-ids "$instance_id"