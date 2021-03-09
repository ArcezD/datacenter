# create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Repository = var.repo_url
  }
}

# create public subnet
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Repository = var.repo_url
  }
}

resource "random_pet" "pet" {}

# create nic interface
resource "aws_network_interface" "nic" {
  description = "${random_pet.pet.id}-nic"
  subnet_id   = aws_subnet.public_subnet_a.id
  private_ips = [var.ec2_ip_address]

  tags = {
    Repository = var.repo_url
  }
}

# create security group
resource "aws_security_group" "unifi-sg" {
  name = "${random_pet.pet.id}-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = var.ec2_keypair_name
  public_key = var.ec2_keypair_value
}

# create unifi controller ec2 instance
resource "aws_instance" "unifi_controller" {
  ami           = "ami-0b75998a97c952252"
  instance_type = "t4g.micro"

  network_interface {
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }

  vpc_security_group_ids = [aws_security_group.unifi-sg.id]

  tags = {
    Name       = "${random_pet.pet.id}-vm",
    Repository = var.repo_url
  }
}

