output "sg_services_only" {
  value = "${aws_security_group.sg_services_only.id}"
}

output "sg_allow_all" {
  value = "${aws_security_group.sg_allow_all.id}"
}
