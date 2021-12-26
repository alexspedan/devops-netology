//PUBLIC!!!
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.public.id
  cidr_block = "10.10.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.public.id

  tags = {
    Name = "public"
  }
}

data "aws_ec2_local_gateway_route_table" "public" {
  outpost_arn = "arn:aws:outposts:us-west-2:123456789012:outpost/op-1234567890abcdef"
}

resource "aws_vpc" "public" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_ec2_local_gateway_route_table_vpc_association" "public" {
  local_gateway_route_table_id = data.aws_ec2_local_gateway_route_table.public.id
  vpc_id                       = aws_vpc.public.id
}

resource "aws_security_group_rule" "public" {
  type              = "ingress"
  from_port         = 8
  to_port           = 0
  protocol          = "icmp"
  cidr_blocks       = [aws_vpc.public.cidr_block]
  ipv6_cidr_blocks  = [aws_vpc.public.ipv6_cidr_block]
  security_group_id = "sg-public-icmp"
}

resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.public.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        // This means, all ip address are allowed to ssh ! 
        // Do not do it in the production. 
        // Put your office or home address in it!
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_nat_gateway" "public" {
  allocation_id = aws_vpc.public.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }
}

//PRIVATE!!!
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.private-vpc.id
  cidr_block = "10.10.2.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "private"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.private-vpc.id
  route {
    cidr_block = "10.10.2.0/24"
    gateway_id = aws_internet_gateway.gw.id
  }
}