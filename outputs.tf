output "vpc" {
  value = "${module.vpc.name}"
}

output "vpc_region" {
  value = "${module.vpc.region}"
}

##############################################################
# private subnet outputs
##############################################################
output "private_subnet_01" {
  value = "${module.subnet_private_01.name}"
}

output "private_subnet_01_id" {
  value = "${module.subnet_private_01.id}"
}

output "private_subnet_01_az" {
  value = "${var.subnet_private_01_az}"
}

output "private_subnet_01_access" {
  value = "${module.subnet_private_01.key_name}"
}

output "private_subnet_02" {
  value = "${module.subnet_private_02.name}"
}

output "private_subnet_02_id" {
  value = "${module.subnet_private_02.id}"
}

output "private_subnet_02_az" {
  value = "${var.subnet_private_02_az}"
}

output "private_subnet_02_access" {
  value = "${module.subnet_private_02.key_name}"
}

##############################################################
# public subnet outputs
##############################################################

output "public_subnet" {
  value = "${module.subnet_public.name}"
}

output "public_subnet_az" {
  value = "${module.subnet_public.az}"
}

output "public_subnet_id" {
  value = "${module.subnet_public.id}"
}

output "public_subnet_access" {
  value = "${module.subnet_public.key_name}"
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
