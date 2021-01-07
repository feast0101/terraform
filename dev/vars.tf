variable "AWS_REGION" {
  type = string
}
variable "AWS_AMI" {
 type = string 
}
variable "instance_type" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "subnet_cidr" {
  type = string
}
variable "ec2_count" {
  type = number
}
variable "tenancy" {
    type = string
}