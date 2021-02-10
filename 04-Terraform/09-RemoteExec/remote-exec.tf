terraform {
  backend "local" {
    path = "/var/tmp/terraform-local-backend/terraform.tfstate"
  }
}



provider "aws" {
  region  = var.region
  version = ">=3.7,<=3.11"
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
  count             = 1
  key_name          = var.key_name
  vpc_security_group_ids = [var.sg_id]
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "Dev-test-App"
  }

  connection { 
    type = "ssh"
    user = "ec2-user"
    private_key = file(var.pvt_key_name)
    host  = self.public_ip 
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd"
    ]

  }
}


output "backend_public_ips" {
  value = aws_instance.backend.*.public_ip
}

output "backend_public_dns" {
  value = aws_instance.backend.*.public_dns
}

