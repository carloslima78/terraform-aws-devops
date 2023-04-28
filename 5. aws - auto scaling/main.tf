terraform {
  required_version = ">=1.3.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.58.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }

  // backend "s3" {}
}

provider "aws" {

  region = var.aws_region

}