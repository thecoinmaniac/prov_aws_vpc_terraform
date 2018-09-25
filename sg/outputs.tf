output "private_security_group_id" {
  value = "${aws_security_group.pri_sg.id}"
}

output "public_security_group_id" {
  value = "${aws_security_group.pub_sg.id}"
}
