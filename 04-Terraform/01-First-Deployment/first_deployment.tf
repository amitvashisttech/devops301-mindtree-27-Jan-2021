# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"
}

resource "aws_instance" "web" {
  ami           = "ami-01aab85a5e4a5a0fe"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}
