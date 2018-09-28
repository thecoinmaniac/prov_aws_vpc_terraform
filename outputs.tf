output "vpc" {
  value = "${module.custom_vpc.vpc_name}"
}

output "vpc_region" {
  value = "${module.custom_vpc.vpc_region}"
}

output "private_subnet_01" {
  value = "${module.private_subnet_01.subnet_name}"
}

output "private_subnet_01_az" {
  value = "${var.pri_sn_01_az}"
}

output "private_subnet_02" {
  value = "${module.private_subnet_02.subnet_name}"
}

output "private_subnet_02_az" {
  value = "${var.pri_sn_02_az}"
}

output "public_subnet" {
  value = "${module.public_subnet.subnet_name}"
}

output "public_subnet_az" {
  value = "${var.pub_sn_az}"
}

output "public_subnet_id" {
  value = "${module.public_subnet.subnet_id}"
}

output "private_security_group" {
  value = "${var.pri_sg}"
}

output "public_security_group" {
  value = "${var.pub_sg}"
}

output "public_security_group_id" {
  value = "${module.security_groups.sg_allow_all}"
}

output "nat_gateway" {
  value = "${module.nat_gateway.nat_gateway_ip}"
}

output "bastion_access_key" {
  value = "${module.nat_gateway.bastion_key}"
}
