# Expected variables from the caller
variable "vpc_id" {}
variable "nat_ami_id" {}
variable "nat_instance_type" {}

variable "pub_sn" {}
variable "public_key" {}
variable "pub_sn_id" {}
variable "pub_sn_az" {}

variable "pri_sn_cidr" {
    type = "list"
}
