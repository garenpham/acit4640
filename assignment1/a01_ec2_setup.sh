#!/bin/bash

# Source the state file
source state_file_vpc.txt


# Create EC2 instance
instance_id=$(aws ec2 run-instances --image-id ami-04203cad30ceb4a0c --count 1 --instance-type t2.micro --key-name acit_4640 --security-group-ids "$sg_id" --subnet-id "$subnet_id" --query 'Instances[0].InstanceId' --output text)

# Tag EC2 instance
aws ec2 create-tags --resources "$instance_id" --tags Key=Project,Value=a1_project Key=Name,Value=a1_ec2

# Save instance ID
{
  echo "instance_id=$instance_id"
} > state_file_ec2.txt
