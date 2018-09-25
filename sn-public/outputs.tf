output "private_subnet_01_id" {
  value = "${aws_subnet.pri_sn_01.id}"
}

output "public_subnet_01_id" {
  value = "${aws_subnet.pub_sn_01.id}"
}
