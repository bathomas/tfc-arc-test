provider "aws" {
  region = var.region
}

data "aws_ami" "rhel8" {
  most_recent = true

  filter {
    name   = "name"
    values = ["aws-rhel8-20211019114321"]
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

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
