
// Ambiente (Dev, Prod)
variable "environment" {

  type        = string
  description = ""
  // default     = "Dev"
}

// Região
variable "aws-region" {

  type        = string
  description = ""
  default     = "us-east-1"
}

// AMI da imagem da instância EC2
variable "ec2-instance-ami" {

  type        = string
  description = ""
  // default     = "ami-0263e4deb427da90e"
}

// Tipo da instância EC2
variable "ec2-instance-type" {

  type        = string
  description = ""
  // default     = "t3.micro"
}

// Tags
variable "ec2-instance-tags" {

  type        = map(string)
  description = ""
  default = {

    Name    = "Ubuntu"
    Project = "Estudo de IaaC na AWS com Terraform"
  }
}
