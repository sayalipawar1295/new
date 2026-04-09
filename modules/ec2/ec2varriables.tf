
variable "ami_id" {
  type = string

}

variable "ins_type" {
  type = string

}

variable "key_pair" {
  type = string

}

# additional variables do not copy in main variable file

variable "subnet_id" {
    type = string
}

variable "security_group" {
  type = string
}
