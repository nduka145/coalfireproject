provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "iamnduka"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

# Create a VPC
resource "aws_vpc" "prod" {
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "Prod-vpc"
  }
}
resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.1.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub1"
  }
}

resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.prod.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub2"
  }
}
resource "aws_subnet" "sub3" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.1.2.0/24"

  tags = {
    Name = "sub3"
  }
}

resource "aws_subnet" "sub4" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.1.3.0/24"

  tags = {
    Name = "sub4"
  }
}
resource "aws_internet_gateway" "prodgw" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = "prod-GW"
  }
}
resource "aws_route_table" "prod-route" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prodgw.id
  }

  tags = {
    Name = "production-route"
  }
}

resource "aws_route_table_association" "as-sub1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.prod-route.id
}

resource "aws_route_table_association" "as-sub2" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.prod-route.id
}

