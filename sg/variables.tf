variable "pri_sg" {
  description = "Security group for private traffic"
  default = "pri_sg"
}

variable "pub_sg" {
  description = "Security group for public traffic"
  default = "pub_sg"
}
