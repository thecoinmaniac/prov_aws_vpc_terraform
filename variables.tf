# main creds for AWS connection
variable "aws_access_key_id" {
  description = "AWS access key"
  default = ""
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  default = ""
}

## Network naming scheme
## VPC: Ocean
## Public Subnet: pub_[Ocean Currents]
## Private Subnet: pri_[Ocean Currents]

variable "vpc_region" {
  description = "AWS region"
  default = "us-east-2"
}

variable "vpc_name" {
  description = "VPC for building demos"
  default = "pacific"
}

variable "vpc_cidr_block" {
  description = "Uber IP addressing for demo Network"
  default = "10.1.0.0/16"
}

variable "pri_sg" {
  description = "Security group for private traffic"
  default = "pri_sg"
}

variable "pub_sg" {
  description = "Security group for public traffic"
  default = "pub_sg"
}
