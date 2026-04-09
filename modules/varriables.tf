
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for vpc"

}


variable "subnet_cidr_block" {
  type        = string
  description = "cidr block for subnet"

}

variable "az" {
  type = string

}

variable "assign_pub_ip" {
  type = bool

}


variable "ami_id" {
  type = string

}

variable "ins_type" {
  type = string

}

variable "key_pair" {
  type = string

}
