provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

resource "aws_s3_bucket" "tf_s3" {
  bucket = "tf-s3-20210104"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}