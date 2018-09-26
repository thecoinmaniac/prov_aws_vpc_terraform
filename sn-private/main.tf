resource "aws_subnet" "private_subnet" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"
  availability_zone = "${var.subnet_az}"
  tags {
    Name = "${var.subnet_name}"
  }
}

# Routing table for private subnet
resource "aws_route_table" "rt_private_subnet" {
  vpc_id = "${var.vpc_id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${var.nat_gw_id}"
  }

  tags {
    Name = "rt_${var.subnet_name}"
  }
}

# Associate the routing table to private subnet
resource "aws_route_table_association" "rt_assn" {
  subnet_id = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.rt_private_subnet.id}"
}
