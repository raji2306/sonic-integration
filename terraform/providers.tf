terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID   # expects this variable
  secret_key = var.AWS_SECRET_ACCESS_KEY
}
