terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "deployed_from_terraform" {
  ami           = "ami-01e444924a2233b07"
  instance_type = "t2.micro"
  key_name = "pracc"

  tags = {
    Name = "terraformUbuntu"
  }
}
