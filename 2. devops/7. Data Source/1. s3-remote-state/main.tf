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

# Consulta dados da conta AWS
data "aws_caller_identity" "current" {}

# Provisiona o Bucket S3
resource "aws_s3_bucket" "remote-state-bucket30032015" {

  # Nomeia o banco com o nome da conta recuperado do "data" acima
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"

  #Habilita o versionamento do Bucket para versionar os arquivos .tfstate
  versioning {

    enabled = true
  }

  tags = {

    Description = "Armazena arquivos tfstate"
    Managedby   = "Terraform"
    Owner       = "Carlão"
  }
}

# Output para expor o nome do Bucket
output "remote_state_bucket" {

  value = aws_s3_bucket.remote-state-bucket30032015
}

# Output para expor o ARN do Bucket
output "remote_state_bucket_arn" {

  value = aws_s3_bucket.remote-state-bucket30032015.arn
}

