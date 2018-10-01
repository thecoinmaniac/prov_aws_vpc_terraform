output "subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "subnet_name" {
  value = "${var.subnet_name}"
}

output "private_subnet_access" {
  value = "${aws_key_pair.private_subnet_access.public_key}"
}

output "private_subnet_access_keyname" {
  value = "${aws_key_pair.private_subnet_access.key_name}"
}
