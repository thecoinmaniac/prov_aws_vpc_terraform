output "vpc" {
  value = "${module.custom_vpc.vpc_name}"
}

output "vpc_region" {
  value = "${module.custom_vpc.vpc_region}"
}

output "private_subnet_01" {
  value = "${module.private_subnet_01.subnet_name}"
}

output "private_subnet_01_id" {
  value = "${module.private_subnet_01.subnet_id}"
}

output "private_subnet_01_az" {
  value = "${var.pri_sn_01_az}"
}

output "private_subnet_01_access" {
  value = "${module.private_subnet_01.private_subnet_access_keyname}"
}

output "private_subnet_02" {
  value = "${module.private_subnet_02.subnet_name}"
}

output "private_subnet_02_id" {
  value = "${module.private_subnet_02.subnet_id}"
}

output "private_subnet_02_az" {
  value = "${var.pri_sn_02_az}"
}

output "private_subnet_02_access" {
  value = "${module.private_subnet_02.private_subnet_access_keyname}"
}

output "public_subnet" {
  value = "${module.public_subnet.name}"
}

output "public_subnet_az" {
  value = "${module.public_subnet.az}"
}

output "public_subnet_id" {
  value = "${module.public_subnet.id}"
}

output "public_subnet_access" {
  value = "${module.public_subnet.key_name}"
}

output "private_security_group" {
  value = "${var.pri_sg}"
}

output "private_security_group_id" {
  value = "${module.security_groups.sg_services_only}"
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
  sensitive = true
  value     = "${module.nat_gateway.bastion_key}"
}
