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

# Região
provider "aws" {

  region = var.aws-region
}

# Configurações da instância EC2 
resource "aws_instance" "web" {

  # Para workspace dev, duas instâncias, caso contrário serão quatro instâncias.
  count = (terraform.workspace == "dev") ? 2 : 4

  ami           = var.ec2-ami
  instance_type = var.ec2-type
  tags = var.ec2-tags

}



