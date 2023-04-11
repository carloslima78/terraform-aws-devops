
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

// Nome randômico que será atribuído ao Bucket
resource "random_pet" "this" {
  
  length = 5
}

// Módulo associado ao recurso S3 que será criado
module "bucket" {
  
  // Pasta de origem onde está o recurso
  source = "./1. S3 Module"

  name = random_pet.this.id
}

// Nome randômico que será atribuído ao Website
resource "random_pet" "website" {
  
  length = 5
}

// Módulo associado ao recurso Website que será criado
module "website" {
  
  // Pasta de origem onde está o recurso
  source = "./1. S3 Module"

  name = random_pet.website.id

  website = {
    
    index_document = "index.html"

    error_document = "error.html"
  }

  // Politica para permitir que o website seja acessado publicamente
  policy = <<EOT
  {

    "Statement": [
      {
        "Sid": "PublicReadGetObject",

        "Effect": "Allow",

        "Principal": "*",

        "Action": [
            "s3:GetObject"
        ],
        
        "Resource": [
          "arn:aws:s3:::${random_pet.website.id}/*"
        ]
      }
    ]
  }
  EOT

}

