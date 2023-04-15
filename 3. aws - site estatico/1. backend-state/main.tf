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

# Consulta dados da conta AWS
data "aws_caller_identity" "current" {}

# Provisiona o Bucket S3
resource "aws_s3_bucket" "remote-state" {

  # Nomeia o bucket concatenando o ID da conta recuperado do "data" acima
  bucket = "tfstate-${data.aws_caller_identity.current.account_id}"

  # Permitirá que o bucket seja removido com o comando "destroy" mesmo não estando vazio.
  force_destroy = true

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

# tabela DynamoDB usada pelo backend para controlar o bloqueio de estado durante as operações de gravação. 
resource "aws_dynamodb_table" "lock-table" {

  # Nomeia a tabela DynamoDB concatenando o nome do bucket S3
  name           = "tflock-${aws_s3_bucket.remote-state.bucket}"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


