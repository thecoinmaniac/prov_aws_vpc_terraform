module "custom_vpc" {
  source = "./vpc"

  aws_access_key_id     = "${var.aws_access_key_id}"
	aws_secret_access_key = "${var.aws_secret_access_key}"
	vpc_region            = "${var.vpc_region}"
  vpc_name              = "${var.vpc_name}"
  vpc_cidr_block        = "${var.vpc_cidr_block}"
}

module "private_subnet_01" {
  source = "./sn-private"

  aws_access_key_id     = "${var.aws_access_key_id}"
	aws_secret_access_key = "${var.aws_secret_access_key}"
  vpc_id        = "${module.custom_vpc.vpc_id}"
  vpc_region    = "${var.vpc_region}"
  subnet_cidr   = "${var.pri_sn_01_cidr}"
  subnet_name   = "${var.pri_sn_01}"
  subnet_az     = "${var.pri_sn_01_az}"
}

module "private_subnet_02" {
  source = "./sn-private"

  aws_access_key_id     = "${var.aws_access_key_id}"
	aws_secret_access_key = "${var.aws_secret_access_key}"
  vpc_id        = "${module.custom_vpc.vpc_id}"
  vpc_region    = "${var.vpc_region}"
  subnet_cidr   = "${var.pri_sn_02_cidr}"
  subnet_name   = "${var.pri_sn_02}"
  subnet_az     = "${var.pri_sn_02_az}"
}

module "public_subnet" {
  source = "./sn-public"

  aws_access_key_id     = "${var.aws_access_key_id}"
	aws_secret_access_key = "${var.aws_secret_access_key}"
  vpc_id        = "${module.custom_vpc.vpc_id}"
  vpc_region    = "${var.vpc_region}"
  subnet_cidr   = "${var.pub_sn_cidr}"
  subnet_name   = "${var.pub_sn}"
  subnet_az     = "${var.pub_sn_az}"
}

module "security_groups" {
  source = "./sg"

  aws_access_key_id     = "${var.aws_access_key_id}"
	aws_secret_access_key = "${var.aws_secret_access_key}"
  vpc_id        = "${module.custom_vpc.vpc_id}"
  vpc_region    = "${var.vpc_region}"
  private_sg    = "${var.pri_sg}"
  public_sg     = "${var.pub_sg}"
  public_subnet_cidr = "${var.pub_sn_cidr}"
}
