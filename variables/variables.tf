variable "vpc_cidr_block" {
  default = "192.168.0.0/16"
}

variable "subnet_cidr_block" {
  default = ["192.168.0.0/22", "192.168.4.0/22"]
}

variable "az" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "assign_pub_ip" {
  default = true
}

variable "ami_id" {
  default = "ami-045443a70fafb8bbc"
}

variable "ins_type" {
  default = "t3.micro"
}

variable "key_pair" {
  default = "oncdec-b36"
}

variable "no_public_ip" {
  default = false
}
