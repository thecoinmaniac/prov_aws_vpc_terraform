# NAT Gateway security group
# Since we'll also use NAT Gateway as a bastion host to get into private subnet,
# it needs block all unnecessary traffic. This should only allow
# - ingress SSH from internet
# - ingress from private subnets
# - egress to internet for any traffic
resource "aws_security_group" "nat_sg" {
  name = "nat_sg_${var.pub_sn}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = "${var.pri_sn_cidr}"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags {
    Name = "nat_sg_${var.pub_sn}"
  }
}

## NAT Gateway.
## This will be needed by any private subnet(s) to connect to Internet
resource "aws_instance" "nat_gw" {
  ami = "${var.nat_ami_id}"
  availability_zone = "${var.pub_sn_az}"
  instance_type = "${var.nat_instance_type}"
  key_name = "${var.bastion_access}"

  subnet_id = "${var.pub_sn_id}"
  vpc_security_group_ids = [
    "${aws_security_group.nat_sg.id}"]

  associate_public_ip_address = true
  source_dest_check = false


  tags = {
    Name = "nat_gw_${var.pub_sn}"
  }
}

resource "aws_eip" "nat_eip" {
  instance = "${aws_instance.nat_gw.id}"
  vpc = true
}
