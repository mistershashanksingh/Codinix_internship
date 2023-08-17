provider "aws" {
  region = "us-east-1"
  access_key = "AKIAX26GYKJTOWAINUGB"
  secret_key = "Rgzy0+y1Bqi+3WI55fWT4IoZ34gpLccxUIA4+uXp"
}

locals {
  sample_env = "sample"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name ="${local.sample_env} vpc"
  }
}

resource "aws_instance" "sample-ec2" {
  ami = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  
  tags = {
    Name ="${local.sample_env} EC2"
  } 
}