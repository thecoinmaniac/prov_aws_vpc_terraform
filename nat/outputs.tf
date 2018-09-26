output "nat_gateway_ip" {
  value = "${aws_eip.nat_eip.public_ip}"
}

output "nat_gateway_id" {
  value = "${aws_instance.nat_gw.id}"
}
