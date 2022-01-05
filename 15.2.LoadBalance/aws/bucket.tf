resource "aws_s3_bucket" "netology-apedan" {
  bucket = "netology-apedan"

  tags = {
    Name        = "netology"
  }
}

resource "aws_s3_bucket_object" "image" {
  bucket = aws_s3_bucket.netology-image.id
  key    = "ny.jpg"
  source = "ny.jpg"
  acl    = "public-read"

  tags = {
    Name   = "New year"

  }
  depends_on = [aws_s3_bucket.netology-apedan]
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_launch_template" "ec2_netology" {
  name_prefix   = "web-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "aws_key"


  placement {
    availability_zone = var.region
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.allow_http.id, aws_security_group.allow_ssh_icmp.id]
  }

  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 1
  }

  user_data = filebase64("./bootstrap.sh")
}