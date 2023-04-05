
terraform {

  required_version = ">=1.3.7"

  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "4.58.0"

    }
  }

  // Backend que armazenará os dados de estado da instância EC2 para serem consultados no S3 de destino.
  backend "s3" {

    # Nome do Bucket
    bucket = "tfstate-303315406913"

    # Prefixo onde será salvo o arquivo no Bucket
    key = "dev/usando-data-source/terraform.tfstate"

    # Região
    region = "us-east-1"

  }

}

provider "aws" {

  region = var.aws-region
}

