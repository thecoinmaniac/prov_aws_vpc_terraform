output "nat_gateway_ip" {
  value = "${aws_eip.nat_eip.public_ip}"
}

output "nat_gateway_id" {
  value = "${aws_instance.nat_gw.id}"
}

output "bastion_key" {
  sensitive = true
  value     = "${tls_private_key.bastion_key.private_key_pem}"
}

output "bastion_access" {
  value = "${aws_key_pair.bastion_access.key_name}"
}
