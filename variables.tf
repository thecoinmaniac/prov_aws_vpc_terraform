# main creds for AWS connection
variable "aws_access_key_id" {
  description = "AWS access key"
  default = ""
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
  default = ""
}

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
  default = "10.0.0.0/16"
}

variable "pub_sn" {
  description = "Public subnet for demo Network"
  default = "pub_peru"
}

variable "pub_sn_cidr" {
  description = "CIDR for externally accessible subnet"
  default = "10.0.1.0/24"
}

variable "pub_sn_az" {
  description = "Region for public subnet"
  default = "us-east-2a"
}

variable "pri_sn_01" {
  description = "Private subnet for demo Network"
  default = "pri_cali"
}

variable "pri_sn_01_cidr" {
  description = "CIDR for internal subnet"
  default = "10.0.128.0/24"
}

variable "pri_sn_01_az" {
  description = "Region for private subnet"
  default = "us-east-2b"
}

variable "pri_sn_02" {
  description = "Private subnet for demo Network"
  default = "pri_elnino"
}

variable "pri_sn_02_cidr" {
  description = "CIDR for internal subnet"
  default = "10.0.129.0/24"
}

variable "pri_sn_02_az" {
  description = "Region for private subnet"
  default = "us-east-2c"
}

variable "pri_sg" {
  description = "Security group for private traffic"
  default = "pri_sg"
}

variable "pub_sg" {
  description = "Security group for public traffic"
  default = "pub_sg"
}
