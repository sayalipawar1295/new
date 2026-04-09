module "vpc" {
    source = "./modules/vpc"
    vpc_cidr_block = var.vpc_cidr_block
    subnet_cidr_block = var.subnet_cidr_block
    az = var.az
    assign_pub_ip = var.assign_pub_ip
}

module "ec2" {
    source = "./modules/ec2"
    ami_id = var.ami_id 
    ins_type = var.ins_type 
    key_pair = var.key_pair 
    subnet_id =  module.vpc.subnet_id
    security_group = module.vpc.security_group
}

