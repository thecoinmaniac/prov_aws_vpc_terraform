# Public subnet
resource "aws_subnet" "pub_sn_01" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  cidr_block = "${var.pub_sn_01_cidr}"
  availability_zone = "us-east-1a"
  tags {
    Name = "${var.pub_sn_01}"
  }
}

# Private subnet
resource "aws_subnet" "pri_sn_01" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  cidr_block = "${var.pri_sn_01_cidr}"
  availability_zone = "us-east-1b"
  tags {
    Name = "${var.pri_sn_01}"
  }
}

# Internet gateway for the public subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  tags {
    Name = "igw_${var.vpc_name}"
  }
}

# Routing table for public subnet
resource "aws_route_table" "rt_pub_sn_01" {
  vpc_id = "${aws_vpc.primary_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "rt_${var.pub_sn_01}"
  }
}

# Associate the routing table to public subnet
resource "aws_route_table_association" "rt_assn_pub_sn_01" {
  subnet_id = "${aws_subnet.pub_sn_01.id}"
  route_table_id = "${aws_route_table.rt_pub_sn_01.id}"
}
