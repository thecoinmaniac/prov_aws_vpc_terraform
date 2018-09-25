# Setup our aws provider
provider "aws" {
  access_key  = "${var.aws_access_key_id}"
  secret_key  = "${var.aws_secret_access_key}"
  region      = "${var.vpc_region}"
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"
  availability_zone = "${var.subnet_az}"
  tags {
    Name = "${var.subnet_name}"
  }
}

# Internet gateway for the public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "igw_${var.subnet_name}"
  }
}

# Routing table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "rt_${var.subnet_name}"
  }
}

# Associate the routing table to public subnet
resource "aws_route_table_association" "route_table_assn" {
  subnet_id = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_route_table.id}"
}
