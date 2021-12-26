terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  access_key = $AWS_ACCESS_ID
  secret_key = $AWS_ACCESS_SECRET
  region = $AWS_DEFAULT_REGION
}
