resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_vpc" "private-vpc" {
    cidr_block = "10.10.2.0/24"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"    
}