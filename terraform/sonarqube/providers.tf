terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket         = "sonic-integration-bucket"
    key            = "sonarqube/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "dynamo"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-south-1"
}
