variable "myvar" {
  type = string
  default = "hello terraform"
}
variable "mymap" {
  type = map(string)
  default = {
    tf = "terraform"
  }
}
variable "mylist" {
  type = list(string)
  default = [1,2,3]
}
variable "AWS_REGION" {
  type =string
}
variable "AMIS" {
  type = map
  default = {
      ap-south-1 = "ami-0d2ffa56cbd31f725"
      us-west-2 = "ami-06b94666"
      eu-west-1 = "ami-0d729a60"
  }
}
variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}