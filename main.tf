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

module "vpc" {
  source = "./vpc"

  vpc_region     = "${var.vpc_region}"
  vpc_name       = "${var.vpc_name}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
}

module "subnet_public" {
  source = "./sn-public"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_name = "${var.subnet_public}"
  subnet_cidr = "${var.subnet_public_cidr}"
  subnet_az   = "${var.subnet_public_az}"
}

module "subnet_private_01" {
  source = "./sn-private"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_cidr = "${var.subnet_private_01_cidr}"
  subnet_name = "${var.subnet_private_01}"
  subnet_az   = "${var.subnet_private_01_az}"
}

module "subnet_private_02" {
  source = "./sn-private"

  vpc_id      = "${module.vpc.id}"
  vpc_region  = "${module.vpc.region}"
  subnet_cidr = "${var.subnet_private_02}"
  subnet_name = "${var.subnet_private_02_cidr}"
  subnet_az   = "${var.subnet_private_02_az}"
}

module "nat_gateway" {
  source            = "./nat"
  vpc_id            = "${module.vpc.id}"
  nat_ami_id        = "${var.nat_ami_id}"
  nat_instance_type = "${var.nat_instance_type}"

  pub_sn    = "${module.subnet_public.name}"
  pub_sn_id = "${module.subnet_public.id}"
  pub_sn_az = "${module.subnet_public.az}"

  pri_sn_cidr = [
    "${var.subnet_private_01_cidr}",
    "${var.subnet_private_02_cidr}",
  ]

  pri_sn_01       = "${module.subnet_private_01.name}"
  pri_sn_01_rt_id = "${module.subnet_private_01.route_table_id}"
  pri_sn_01_key   = "${module.subnet_private_01.private_key}"

  pri_sn_02       = "${module.subnet_private_02.name}"
  pri_sn_02_rt_id = "${module.subnet_private_02.route_table_id}"
  pri_sn_02_key   = "${module.subnet_private_02.private_key}"

  public_key = "${module.subnet_public.public_key}"
}

###############################################################################
# Traffic Control
###############################################################################

module "security_groups" {
  source = "./sg"

  vpc_id             = "${module.vpc.id}"
  vpc_region         = "${module.vpc.region}"
  private_sg         = "${var.pri_sg}"
  public_sg          = "${var.pub_sg}"
  public_subnet_cidr = "${var.subnet_public_cidr}"
}
