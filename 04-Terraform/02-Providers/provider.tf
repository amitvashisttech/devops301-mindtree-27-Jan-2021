provider "aws" {
  region = "us-east-2"
  version = ">=3.7,<=3.11"
}


provider "aws" {
  region = "us-west-2"
  version = ">=3.7,<=3.11"
  alias  = "us-west-2"
}


resource "aws_instance" "example_east" {
  ami           = "ami-01aab85a5e4a5a0fe"
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}



resource "aws_instance" "example_west" {
  ami           = "ami-0e999cbd62129e3b1"
  instance_type = "t2.micro"
  provider   = aws.us-west-2

  tags = {
    Name = "HelloWorld"
  }
}
