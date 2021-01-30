resource "aws_instance" "backend" {
  ami               = "ami-0ebc8f6f580a04647"
  instance_type     = "t2.micro"
#  availability_zone = data.aws_availability_zones.zone_east.names[count.index]
#  count             = 1
  key_name          = var.key_name
  vpc_security_group_ids = [var.sg_id]
  lifecycle {
    prevent_destroy = false
  }
  tags = {
    Name = "Dev-App"
  }

  connection { 
    type = "ssh"
    user = "ubuntu"
    private_key = file(var.pvt_key_name)
    host  = self.public_ip 
  }

  
  provisioner "remote-exec" {
    inline = [
      "sudo sleep 30",
      "sudo apt-get update -y",
      "sudo apt-get install python sshpass -y"
    ]

  }
}


resource "null_resource" "ansible-main" { 
  provisioner "local-exec" {
    command = <<EOT
       > jenkins-ci.ini;
       echo "[jenkins-ci]"|tee -a jenkins-ci.ini;
       export ANSIBLE_HOST_KEY_CHECKING=False;
       echo "${aws_instance.backend.public_ip}"|tee -a jenkins-ci.ini;
       ansible-playbook --key-file=${var.pvt_key_name} -i jenkins-ci.ini -u ubuntu ./ansible-code/petclinic.yaml -v 
     EOT
  }
  depends_on = [aws_instance.backend]
}
