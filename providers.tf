terraform {
  required_version = ">=1.12.1"
  backend "s3" {
    bucket         = "francky-bucket-test"
    key            = "test/terraform.tfstate"
    region         = "eu-west-1"
    profile        = "" # AWS profile to use
    dynamodb_table = "captura-terraform-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
