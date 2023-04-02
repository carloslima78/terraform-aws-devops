terraform {

  required_version = ">=1.3.7"

  required_providers {

    # Loca o Provider AWS
    aws = {

      # Dados da origem e versão, encontrados no arquivo ".terraform.lock.hcl"
      source  = "hashicorp/aws"
      version = "4.58.0"

    }

    # Loca o Provider Random
    random = {

      # Dados da origem e versão, encontrados no arquivo ".terraform.lock.hcl"
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
}

provider "aws" {

  region = var.aws-region
}