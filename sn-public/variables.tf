variable "pub_sn_01" {
  description = "Public subnet for demo Network"
  default = "pub_peru"
}

variable "pub_sn_01_cidr" {
  description = "CIDR for externally accessible subnet"
  #default = "192.168.1.0/24"
  default = "10.1.0.0/24"
}

variable "pri_sn_01" {
  description = "Private subnet for demo Network"
  default = "pri_cal"
}

variable "pri_sn_01_cidr" {
  description = "CIDR for internal subnet"
  #default = "192.168.128.0/24"
  default = "10.2.0.0/24"
}
