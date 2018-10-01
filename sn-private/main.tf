resource "aws_subnet" "private_subnet" {
  vpc_id            = "${var.vpc_id}"
  cidr_block        = "${var.subnet_cidr}"
  availability_zone = "${var.subnet_az}"

  tags {
    Name = "${var.subnet_name}"
  }
}

# Routing table for private subnet
resource "aws_route_table" "rt_private_subnet" {
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "rt_${var.subnet_name}"
  }
}

# Associate the routing table to private subnet
resource "aws_route_table_association" "rt_assn" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.rt_private_subnet.id}"
}

## Create a private key that'll be used for access to Bastion host
resource "tls_private_key" "private_subnet_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "private_subnet_access" {
  key_name   = "${var.subnet_name}_access"
  public_key = "${tls_private_key.private_subnet_key.public_key_openssh}"
}
