resource "aws_s3_bucket" "tf_s3" {
  bucket = "tf-s3-20210104"
  acl    = "private"
}

resource "aws_default_vpc" "default" {}

resource "aws_security_group" "prod_web" {
  name = "prod_web"
  description = "allows standard http and https ports inbound and everything outbound"

  ingress {
     from_port = 80
     to_port =80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
     from_port = 443
     to_port = 443
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
     from_port = 0
     to_port = 0
     protocol = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "terraform" = "true"
  }
}
resource "aws_instance" "prod_web" {
  count = 3
  ami = lookup(var.AMIS, var.AWS_REGION) # "ami-0d2ffa56cbd31f725"
  instance_type = "t2.nano"

  vpc_security_group_ids = [ 
    aws_security_group.prod_web.id 
    ]

  tags = {
    "terraform" = "true"
  }
}
resource "aws_eip_association" "prod_web" {
  instance_id = aws_instance.prod_web.0.id
  allocation_id= aws_eip.prod_web.id
}
resource "aws_eip" "prod_web" {
  instance = aws_instance.prod_web.0.id
  tags = {
      "terraform" = "true"
  }
}

resource "aws_default_subnet" "default_az1" {
  availability_zone = "ap-south-1a"
  tags = {
      "terraform" = "true"
  }
}
resource "aws_default_subnet" "default_az2" {
  availability_zone = "ap-south-1b"
  tags = {
      "terraform" = "true"
  }
}
resource "aws_default_subnet" "default_az3" {
  availability_zone = "ap-south-1c"
  tags = {
      "terraform" = "true"
  }
}
resource "aws_elb" "prod_web" {
  name = "prod-web"
  instances = [ aws_instance.prod_web[0].id, aws_instance.prod_web[1].id, aws_instance.prod_web[2].id ]
  subnets = [ aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id, aws_default_subnet.default_az3.id ]
  security_groups = [ aws_security_group.prod_web.id ]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  tags = {
    "terraform" = "true"
  }
}
#resource "aws_launch_template" "prod_web" {
#  name_prefix = "prod-web"
#  image_id = "ami-0d2ffa56cbd31f725"
#  instance_type = "t2.micro"
#}
#resource "aws_autoscaling_group" "prod_web" {
#  availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
#  vpc_zone_identifier = [aws_default_subnet.default_az1.id, aws_default_subnet.default_az2.id, aws_default_subnet.default_az3.id]
#  desired_capacity = 1
#  max_size =1
#  min_size = 1
  
 # launch_template {
 #   id = aws_launch_template.prod_web.id
 #   version = "$Latest"
 # }
  #tag {
  #  key  = "terraform"
  #  value = "true"
  #  propagate_at_launch = true
  #}
#}
#resource "aws_autoscaling_attachment" "prod_web" {
#  autoscaling_group_name = aws_autoscaling_group.prod_web.id
#  elb = aws_elb.prod_web.id
#}