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

  # Backend S3 para armazenamento físico do arquivo .tfstate
  backend "s3" {

  }
}

provider "aws" {
  
   region  = var.aws_region
}

provider "aws" {
  region  = "us-east-1"
  alias   = "us-east-1"
}

# random_pe para o Website
resource "random_pet" "website" {

  length = 5

}


