output "subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "subnet_name" {
  value = "${var.subnet_name}"
}
