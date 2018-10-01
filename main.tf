###############################################################################
# Provider
###############################################################################
provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
  region     = "${var.vpc_region}"
}

###############################################################################
# Base Network
###############################################################################

module "custom_vpc" {
  source = "./vpc"

  vpc_region     = "${var.vpc_region}"
  vpc_name       = "${var.vpc_name}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
}

module "public_subnet" {
  source = "./sn-public"

  vpc_id      = "${module.custom_vpc.vpc_id}"
  vpc_region  = "${var.vpc_region}"
  subnet_cidr = "${var.pub_sn_cidr}"
  subnet_name = "${var.pub_sn}"
  subnet_az   = "${var.pub_sn_az}"
}

module "private_subnet_01" {
  source = "./sn-private"

  vpc_id      = "${module.custom_vpc.vpc_id}"
  vpc_region  = "${var.vpc_region}"
  subnet_cidr = "${var.pri_sn_01_cidr}"
  subnet_name = "${var.pri_sn_01}"
  subnet_az   = "${var.pri_sn_01_az}"
}

module "private_subnet_02" {
  source = "./sn-private"

  vpc_id      = "${module.custom_vpc.vpc_id}"
  vpc_region  = "${var.vpc_region}"
  subnet_cidr = "${var.pri_sn_02_cidr}"
  subnet_name = "${var.pri_sn_02}"
  subnet_az   = "${var.pri_sn_02_az}"
}

module "nat_gateway" {
  source            = "./nat"
  vpc_id            = "${module.custom_vpc.vpc_id}"
  nat_ami_id        = "${var.nat_ami_id}"
  nat_instance_type = "${var.nat_instance_type}"
  pub_sn            = "${module.public_subnet.subnet_name}"
  pub_sn_id         = "${module.public_subnet.subnet_id}"
  pub_sn_az         = "${var.pub_sn_az}"

  pri_sn_cidr = [
    "${var.pri_sn_01_cidr}",
    "${var.pri_sn_02_cidr}",
  ]

  pri_sn_01         = "${var.pri_sn_01}"
  pri_sn_01_rt_id   = "${module.private_subnet_01.rt_id}"
  pri_sn_01_key     = "${module.private_subnet_01.private_key}"

  pri_sn_02         = "${var.pri_sn_02}"
  pri_sn_02_rt_id   = "${module.private_subnet_02.rt_id}"
  pri_sn_02_key     = "${module.private_subnet_02.private_key}"

  public_key = "${module.public_subnet.public_key}"
}

###############################################################################
# Traffic Control
###############################################################################

module "security_groups" {
  source = "./sg"

  vpc_id             = "${module.custom_vpc.vpc_id}"
  vpc_region         = "${var.vpc_region}"
  private_sg         = "${var.pri_sg}"
  public_sg          = "${var.pub_sg}"
  public_subnet_cidr = "${var.pub_sn_cidr}"
}
