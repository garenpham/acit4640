#!/bin/bash


# Create VPC
vpc_id=$(aws ec2 create-vpc --cidr-block 172.16.0.0/16 --query 'Vpc.VpcId' --output text)

# Enable public hostnames
aws ec2 modify-vpc-attribute --vpc-id "$vpc_id" --enable-dns-hostnames "{\"Value\":true}"


# Create Subnet
subnet_id=$(aws ec2 create-subnet --vpc-id "$vpc_id" --cidr-block 172.16.1.0/24 --query 'Subnet.SubnetId' --output text)

# Modify Subnet attribute to assign public ip
aws ec2 modify-subnet-attribute --subnet-id "$subnet_id" --map-public-ip-on-launch

# Create Internet Gateway and attach to VPC
igw_id=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
aws ec2 attach-internet-gateway --vpc-id "$vpc_id" --internet-gateway-id "$igw_id"

# Create Route Table
route_table_id=$(aws ec2 create-route-table --vpc-id "$vpc_id" --query 'RouteTable.RouteTableId' --output text)

# Create route to Internet Gateway
aws ec2 create-route --route-table-id "$route_table_id" --destination-cidr-block 0.0.0.0/0 --gateway-id "$igw_id"

# Associate Subnet with Route Table
aws ec2 associate-route-table --subnet-id "$subnet_id" --route-table-id "$route_table_id"

# Create Security Group
sg_id=$(aws ec2 create-security-group --group-name a1_web_sg_1 --description "a1_web_sg_1" --vpc-id "$vpc_id" --query 'GroupId' --output text)

# Add rules to Security Group
aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 22 --cidr 142.232.0.0/16 # SSH from BCIT
aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 80 --cidr 142.232.0.0/16 # HTTP from BCIT
aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 22 --cidr 172.31.39.78/20 # SSH from Home
aws ec2 authorize-security-group-ingress --group-id "$sg_id" --protocol tcp --port 80 --cidr 172.31.39.78/20 # HTTP from Home
aws ec2 authorize-security-group-egress --group-id "$sg_id" --protocol tcp --port 80 --cidr 0.0.0.0/0 # HTTP from anywhere


# Tag resources
aws ec2 create-tags --resources "$vpc_id" "$subnet_id" "$igw_id" "$route_table_id" --tags Key=Project,Value=a1_project
aws ec2 create-tags --resources "$vpc_id" --tags Key=Name,Value=a1_vpc
aws ec2 create-tags --resources "$subnet_id" --tags Key=Name,Value=a1_sn_web_1
aws ec2 create-tags --resources "$route_table_id" --tags Key=Name,Value=a1_web_rt_1
aws ec2 create-tags --resources "$igw_id" --tags Key=Name,Value=a1_gw_1

# Save state
{
  echo "vpc_id=$vpc_id"
  echo "subnet_id=$subnet_id" 
  echo "igw_id=$igw_id" 
  echo "route_table_id=$route_table_id"
  echo "sg_id=$sg_id"
} > state_file_vpc.txt