output "vpc_region" {
  value = "${var.vpc_region}"
}

output "vpc_id" {
  value = "${aws_vpc.primary_vpc.id}"
}

output "vpc_name" {
  value = "${var.vpc_name}"
}
