provider "aws" {
  region = var.my_region
}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name : "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "my-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.subnet_cidr_block
  tags = {
    Name : "${var.env_prefix}-subnet"
  }
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.my-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name : "${var.env_prefix}-main-rtb"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name : "${var.env_prefix}-igw"
  }
}

resource "aws_default_security_group" "my-default-sg" {
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = [var.my_ip]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name : "${var.env_prefix}-default-sg"
  }
}

resource "aws_key_pair" "ssh-key-pair" {
  key_name   = "server-key-pair"
  public_key = var.public_key_content
}

resource "aws_instance" "my-app-server" {
  ami                         = var.ami-id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.my-subnet.id
  vpc_security_group_ids      = [aws_default_security_group.my-default-sg.id]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key-pair.key_name
  user_data                   = file("entry-script.sh")

  tags = {
    Name : "${var.env_prefix}-app-server"
  }
}
