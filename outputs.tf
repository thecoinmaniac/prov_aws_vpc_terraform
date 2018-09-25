output "vpc_name" {
  value = "${module.custom_vpc.vpc_name}"
}

output "vpc_region" {
  value = "${module.custom_vpc.vpc_region}"
}

output "private_subnet_01_name" {
  value = "${module.private_subnet_01.subnet_name}"
}

output "private_subnet_02_name" {
  value = "${module.private_subnet_02.subnet_name}"
}
