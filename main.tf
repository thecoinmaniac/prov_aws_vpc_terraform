module "customVPC" {
  source = "./vpc"

  aws_access_key_id     = "${var.aws_access_key_id}"
	aws_secret_access_key = "${var.aws_secret_access_key}"
	vpc_region            = "${var.vpc_region}"
  vpc_name              = "${var.vpc_name}"
  vpc_cidr_block        = "${var.vpc_cidr_block}"
}
