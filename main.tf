provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "example" {
  ami = "ami-0653812935d0743fe"
  instance_type = "t3.micro"

  tags = {
    Name = "terraform-example"
  }
}
