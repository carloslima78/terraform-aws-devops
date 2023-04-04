
terraform {

  required_version = ">=1.3.7"

  # Loca o Provider utilizado
  required_providers {

    aws = {

      # Dados da origem e versão, encontrados no arquivo ".terraform.lock.hcl"
      source  = "hashicorp/aws"
      version = "4.58.0"

    }
  }
}

provider "aws" {

  region = "us-east-1"
}

resource "aws_s3_bucket" "my-test-bucket" {

  bucket = "my-tf-test-bucket-30032015"
  acl    = "private"

  tags = {

    Name        = "My bucket"
    Environment = "Dev"
    Managedby   = "Terraform"
  }
}
