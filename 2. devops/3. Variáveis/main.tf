
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

  region = var.aws-region
}

/* Instância EC2

    Documentação Terraform

    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
*/
resource "aws_instance" "terraform-ec2-teste" {

  ami           = var.ec2-instance-ami
  instance_type = var.ec2-instance-type
  tags          = var.ec2-instance-tags
}