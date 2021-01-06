module "my_vpc" {
    source   = "../modules/vpc"
    vpc_cidr = "192.168.0.0/16"
    tenancy  = "default"
    vpc_id   = module.my_vpc.vpc_id
    subnet_cidr = "192.168.1.0/24"
}

module "my_ce2" {
    source = "../modules/ec2"
    ec2_count = 1
    ami_id = "ami-0d2ffa56cbd31f725"
    instance_type = "t2.micro"
    subnet_id = module.my_vpc.subnet_id
}