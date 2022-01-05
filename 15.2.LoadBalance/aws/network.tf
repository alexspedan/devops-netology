resource "aws_vpc" "netology" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.netology.id
  cidr_block = "10.10.1.0/24"

  map_public_ip_on_launch = true
  availability_zone       = "us-east-2"
  tags = {
    Name = "public1"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.netology.id
  cidr_block = "10.10.3.0/24"

  map_public_ip_on_launch = true
  availability_zone       = "us-east-2"
  tags = {
    Name = "public2"
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc1.id
  tags = {
    Name = "internet-gw"
  }
}

resource "aws_route_table" "public_net_table" {
  vpc_id = aws_vpc.netology.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = {
    Name = "Public net routing table"
  }
}

resource "aws_main_route_table_association" "main" {
  vpc_id         = aws_vpc.netology.id
  route_table_id = aws_route_table.public_net_table.id
}

resource "aws_security_group" "allow_http" {
  name        = "allow-necessary"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.netology.id

  ingress {
    description = "HTTP to netology"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1" # equals protocol = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http"
  }
}

resource "aws_security_group" "allow_ssh_icmp" {
  name        = "allow_ssh_icmp"
  description = "Allow SSH and ICMP inbound traffic"
  vpc_id      = aws_vpc.netology.id

  ingress {
    description = "SSH to VPC"
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "ICMP to VPC"
    from_port = -1
      to_port  = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1" # equals protocol = "all"

    cidr_blocks = ["0.0.0.0/0"]
  }
}