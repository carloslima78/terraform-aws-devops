// Ambiente (Dev, Prod)
variable "environment" {

  type        = string
  description = ""
  default     = "Dev"
}

// Região
variable "aws-region" {

  type        = string
  description = ""
  default     = "us-east-1"
}

// AMI da imagem da instância EC2
variable "ami" {

  type        = string
  description = ""
  default     = "ami-0263e4deb427da90e"
}

// Tipo da instância EC2
variable "type" {

  type        = string
  description = ""
  default     = "t3.micro"
}

// Tags
variable "tags" {

  type        = map(string)
  description = ""
  default = {

    Name = "Remote State"
    Description = "Testando Remote State"
  }
}