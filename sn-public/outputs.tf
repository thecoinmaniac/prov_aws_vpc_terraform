output "subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "subnet_name" {
  value = "${var.subnet_name}"
}

output "bastion_key" {
  value = "${tls_private_key.bastion_key.private_key_pem}"
}

output "bastion_access" {
  value = "${aws_key_pair.bastion_access.key_name}"
}
