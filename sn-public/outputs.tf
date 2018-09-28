output "subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "subnet_name" {
  value = "${var.subnet_name}"
}

output "public_key" {
  value = "${tls_private_key.public_access_key.private_key_pem}"
}

output "public_access" {
  value = "${aws_key_pair.public_access.key_name}"
}
