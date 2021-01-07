module "my_vpc" {
    source   = "../modules/vpc"
    vpc_cidr = var.vpc_cidr
    tenancy  = var.tenancy
    vpc_id   = module.my_vpc.vpc_id
    subnet_cidr = var.subnet_cidr
}

module "my_ce2" {
    source = "../modules/ec2"
    ec2_count = var.ec2_count
    ami_id = var.AWS_AMI
    instance_type = var.instance_type
    subnet_id = module.my_vpc.subnet_id
}