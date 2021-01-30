terraform {
  backend "local" {
    path = "/var/tmp/terraform-local-backend/terraform.tfstate"
  }
}



provider "aws" {
  region  = var.region
  version = ">=3.7,<=3.11"
}

variable "region" {
  default = "us-east-1"
}

data "aws_availability_zones" "zone_east" {}

data "aws_ami" "myami" {
  most_recent = "true"
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}



resource "aws_instance" "backend" {
  ami               = data.aws_ami.myami.id
  instance_type     = "t2.micro"
  availability_zone = data.aws_availability_zones.zone_east.names[count.index]
  count             = 2
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "Dev-test-App"
  }
}


output "backend_public_ips" {
  value = aws_instance.backend.*.public_ip
}

output "backend_public_dns" {
  value = aws_instance.backend.*.public_dns
}

