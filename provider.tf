terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  
  backend "remote" {
    organization = "arce-cr"
    workspaces {
      name = "datacenter"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}