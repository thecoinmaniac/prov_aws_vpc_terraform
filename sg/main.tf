# Private security group
resource "aws_security_group" "sg_services_only" {
  name = "${var.private_sg}"
  description = "Security group to access private ports"
  vpc_id = "${var.vpc_id}"

  # allow memcached port within VPC from public subnet
  ingress {
    from_port = 11211
    to_port = 11211
    protocol = "tcp"
    cidr_blocks = [
      "${var.public_subnet_cidr}"]
  }

  # allow redis port within VPC from public subnet
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = [
      "${var.public_subnet_cidr}"]
  }

  # allow postgres port within VPC from public subnet
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      "${var.public_subnet_cidr}"]
  }

  # allow mysql port within VPC from public subnet
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      "${var.public_subnet_cidr}"]
  }

  # allow all outgoing traffic from private subnet
  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.private_sg}"
  }
}

# Public security group
resource "aws_security_group" "sg_allow_all" {
  name = "${var.public_sg}"
  description = "Public access security group"
  vpc_id = "${var.vpc_id}"

  # allow http traffic
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  # allow https traffic
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [
      "${var.public_subnet_cidr}"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "${var.public_sg}"
  }
}
