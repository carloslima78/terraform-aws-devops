
// Região
variable "aws-region" {

  type    = string
  default = "us-east-1"
}

// AMI da imagem da instância EC2
variable "ec2-ami" {

  type    = string
  default = ""
}

// Tipo da instância EC2
variable "ec2-type" {

  type    = string
  default = ""
}

// Tags para a instância EC2
variable "ec2-tags" {

  type        = map(string)
  default = {
    
  }
}
