output "vpc" {
  value = "${module.custom_vpc.vpc_name}"
}

output "vpc_region" {
  value = "${module.custom_vpc.vpc_region}"
}

output "private_subnet_01" {
  value = "${module.private_subnet_01.subnet_name}"
}

output "private_subnet_02" {
  value = "${module.private_subnet_02.subnet_name}"
}

output "public_subnet" {
  value = "${module.public_subnet.subnet_name}"
}

output "private_security_group" {
  value = "${var.pri_sg}"
}

output "public_security_group" {
  value = "${var.pub_sg}"
}
