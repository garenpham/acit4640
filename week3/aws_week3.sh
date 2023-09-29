#!/bin/bash

vpc_cidr="10.0.0.0/16"
subnet_cidr="10.0.1.0/24"
AZ="us-west-2a"

# Create a new VPC
vpc_id=$(
  aws ec2 create-vpc \
  --cidr-block $vpc_cidr \
  --query Vpc.VpcId --output text
)

# create a new subnet
subnet_id=$(
  aws ec2 create-subnet \
  --cidr-block $subnet_cidr \
  --availability-zone $AZ \
  --vpc-id $vpc_id \
  --query Subnet.SubnetId --output text
)
echo "
  VPC $vpc_id
  Subnet ID $subnet_id
"


