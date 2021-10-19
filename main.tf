provider "aws" {
  region = var.region
}

data "aws_ami" "rhel8" {
  most_recent = true

  filter {
    name   = "name"
    values = ["aws-rhel8-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["239608013568"]
}

resource "aws_instance" "rhel8" {
  ami           = data.aws_ami.rhel8.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
