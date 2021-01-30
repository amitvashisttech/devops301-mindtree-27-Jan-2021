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

  
  provisioner "file" {
    source = "./frontend"
    destination  = "~/"

  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x ~/frontend/run_frontend.sh",
      "sudo sh ~/frontend/run_frontend.sh"
    ]

  }
}
