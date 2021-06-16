# Create VPC in us-east-1
resource "aws_vpc" "vpc_master" {
  provider             = aws.region-master
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "master-vpc-jenkins"
  }
}

# Create VPC in us-west-2
resource "aws_vpc" "vpc_worker" {
  provider             = aws.region-worker
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "worker-vpc-jenkins"
  }
}

# Create VPC in us-east-1
resource "aws_internet_gateway" "igw_master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
}

# Create VPC in us-west-2
resource "aws_internet_gateway" "igw_worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
}

# Get all available AZ's in us-east-1
data "aws_availability_zones" "azs_master" {
  provider = aws.region-master
  state    = "available"
}

# Get all available AZ's in us-east-1
data "aws_availability_zones" "azs_worker" {
  provider = aws.region-worker
  state    = "available"
}

# Create subnet 1 in us-east-1
resource "aws_subnet" "subnet_master_1" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs_master.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"
}

# Create subnet 2 in us-east-1
resource "aws_subnet" "subnet_master_2" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs_master.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"
}

# Create subnet worker 1 in us-west-2
resource "aws_subnet" "subnet_worker_1" {
  provider          = aws.region-worker
  availability_zone = element(data.aws_availability_zones.azs_worker.names, 0)
  vpc_id            = aws_vpc.vpc_worker.id
  cidr_block        = "192.168.1.0/24"
}

# Initiate Peering connection request from us-east-1
resource "aws_vpc_peering_connection" "vpc_peering_master_worker" {
  provider    = aws.region-master
  vpc_id      = aws_vpc.vpc_master.id
  peer_vpc_id = aws_vpc.vpc_worker.id
  peer_region = var.region-worker
}

# Accept VPC peering request in us-west-2 from us-east-1
resource "aws_vpc_peering_connection_accepter" "accept_peering" {
  provider                  = aws.region-worker
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_master_worker.id
  auto_accept               = true
}

# Create route table in us-east-1
resource "aws_route_table" "internet_route_master" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_master.id
  }
  route {
    cidr_block                = "192.168.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_master_worker.id
  }

  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "Master-Region-RT"
  }
}

# Overwrite default route table of VPC (Master) with our route table entries
resource "aws_main_route_table_association" "master_default_rt_assoc" {
  provider       = aws.region-master
  vpc_id         = aws_vpc.vpc_master.id
  route_table_id = aws_route_table.internet_route_master.id
}

# Create route table in us-west-2
resource "aws_route_table" "internet_route_worker" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_worker.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_worker.id
  }
  route {
    cidr_block                = "10.0.1.0/24"
    vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering_master_worker.id
  }

  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "Worker-Region-RT"
  }
}

# Overwrite default route table of VPC (Worker) with our route table entries
resource "aws_main_route_table_association" "worker_default_rt_assoc" {
  provider       = aws.region-worker
  vpc_id         = aws_vpc.vpc_worker.id
  route_table_id = aws_route_table.internet_route_worker.id
}