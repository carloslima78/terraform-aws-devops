
terraform {

  required_version = ">=1.3.7"

  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "4.58.0"

    }
  }
}

provider "aws" {

  region = "us-east-1"
}

resource "random_pet" "this" {
  
  length = 5
}

// Módulo associado ao recurso S3 que será criado
module "bucket" {
  
  // Pasta de origem onde está o recurso
  source = "./1. S3 Module"
  name = random_pet.this.id
}

