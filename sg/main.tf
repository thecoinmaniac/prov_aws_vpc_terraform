# Private security group
resource "aws_security_group" "pri_sg" {
  name = "${var.pri_sg}"
  description = "Security group to access private ports"
  vpc_id = "${aws_vpc.primary_vpc.id}"

  # allow memcached port within VPC from public subnet
  ingress {
    from_port = 11211
    to_port = 11211
    protocol = "tcp"
    cidr_blocks = [
      "${var.pub_sn_01_cidr}"]
  }

  # allow redis port within VPC from public subnet
  ingress {
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = [
      "${var.pub_sn_01_cidr}"]
  }

  # allow postgres port within VPC from public subnet
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
      "${var.pub_sn_01_cidr}"]
  }

  # allow mysql port within VPC from public subnet
  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [
      "${var.pub_sn_01_cidr}"]
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
    Name = "${var.pri_sg}"
  }
}

# Public security group
resource "aws_security_group" "pub_sg" {
  name = "${var.pub_sg}"
  description = "Public access security group"
  vpc_id = "${aws_vpc.primary_vpc.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [
      "${var.pub_sn_01_cidr}"]
  }

  egress {
    # allow all traffic to private SN
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "$var.pub_sg}"
  }
}
