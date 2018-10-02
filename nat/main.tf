# NAT Gateway security group
# Since we'll also use NAT Gateway as a bastion host to get into private subnet,
# it needs block all unnecessary traffic. This should only allow
# - ingress SSH from internet
# - ingress from private subnets
# - egress to internet for any traffic
resource "aws_security_group" "nat_sg" {
  name   = "nat_sg_${var.pub_sn}"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${var.pri_sn_cidr}"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port = -1
    to_port   = -1
    protocol  = "icmp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags {
    Name = "nat_sg_${var.pub_sn}"
  }
}

## Create a private key that'll be used for access to Bastion host/NAT Gateway
resource "tls_private_key" "bastion_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion_access" {
  key_name   = "bastion_access"
  public_key = "${tls_private_key.bastion_key.public_key_openssh}"
}

## Write the private key to access bastion host in a file
resource "local_file" "bastion_access_key" {
  content  = "${tls_private_key.bastion_key.private_key_pem}"
  filename = "${path.module}/id_rsa_bastion"
}

## Write the private key to access public instances in a file
resource "local_file" "public_key" {
  content  = "${var.public_key}"
  filename = "${path.module}/id_rsa_${var.pub_sn}"
}

## Write the private key to access private instances in a file
resource "local_file" "pri_sn_01_key" {
  content  = "${var.pri_sn_01_key}"
  filename = "${path.module}/id_rsa_${var.pri_sn_01}"
}

## Write the private key to access private instances in a file
resource "local_file" "pri_sn_02_key" {
  content  = "${var.pri_sn_02_key}"
  filename = "${path.module}/id_rsa_${var.pri_sn_02}"
}

## NAT Gateway.
## This will be needed by any private subnet(s) to connect to Internet
resource "aws_instance" "nat_gw" {
  ami               = "${var.nat_ami_id}"
  availability_zone = "${var.pub_sn_az}"
  instance_type     = "${var.nat_instance_type}"
  key_name          = "${aws_key_pair.bastion_access.key_name}"
  subnet_id         = "${var.pub_sn_id}"

  vpc_security_group_ids = [
    "${aws_security_group.nat_sg.id}",
  ]

  associate_public_ip_address = true
  source_dest_check           = false

  ## update the permissions of private key file needed to access bastion
  provisioner "local-exec" {
    command = "chmod -c 600 ${path.module}/id_rsa_bastion"
  }

  ## Add the private key to access public instances in .ssh folder
  provisioner "file" {
    source      = "${path.module}/id_rsa_${var.pub_sn}"
    destination = "/home/ec2-user/.ssh/id_rsa_${var.pub_sn}"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${tls_private_key.bastion_key.private_key_pem}"
    }
  }

  ## Add the private key to access private instances in .ssh folder
  provisioner "file" {
    source      = "${path.module}/id_rsa_${var.pri_sn_01}"
    destination = "/home/ec2-user/.ssh/id_rsa_${var.pri_sn_01}"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${tls_private_key.bastion_key.private_key_pem}"
    }
  }

  ## Add the private key to access private instances in .ssh folder
  provisioner "file" {
    source      = "${path.module}/id_rsa_${var.pri_sn_02}"
    destination = "/home/ec2-user/.ssh/id_rsa_${var.pri_sn_02}"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${tls_private_key.bastion_key.private_key_pem}"
    }
  }

  ## Update permissions on all the keys
  provisioner "remote-exec" {
    inline = [
      "chmod -c 600 /home/ec2-user/.ssh/id_rsa_${var.pub_sn}",
      "chmod -c 600 /home/ec2-user/.ssh/id_rsa_${var.pri_sn_01}",
      "chmod -c 600 /home/ec2-user/.ssh/id_rsa_${var.pri_sn_02}",
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "${tls_private_key.bastion_key.private_key_pem}"
    }
  }

  ## Since the private key has been added to bastion host, remove it from local
  provisioner "local-exec" {
    command = "rm -f ${path.module}/id_rsa_${var.pub_sn}"
  }

  provisioner "local-exec" {
    command = "rm -f ${path.module}/id_rsa_${var.pri_sn_01}"
  }

  provisioner "local-exec" {
    command = "rm -f ${path.module}/id_rsa_${var.pri_sn_02}"
  }

  tags = {
    Name = "nat_gw_${var.pub_sn}"
  }
}

resource "aws_eip" "nat_eip" {
  instance = "${aws_instance.nat_gw.id}"
  vpc      = true
}

## Route the internet bound traffic for both public subnets via NAT instance
resource "aws_route" "pri_sn_01_route" {
  route_table_id         = "${var.pri_sn_01_rt_id}"
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = "${aws_instance.nat_gw.id}"
}

resource "aws_route" "pri_sn_02_route" {
  route_table_id         = "${var.pri_sn_02_rt_id}"
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = "${aws_instance.nat_gw.id}"
}
