## Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"
  availability_zone = "${var.subnet_az}"
  tags {
    Name = "${var.subnet_name}"
  }
}

## Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "igw_${var.subnet_name}"
  }
}

## Routing table
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

