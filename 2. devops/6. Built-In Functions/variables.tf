
// Ambiente (Dev, Prod)
variable "environment" {

  type        = string
  description = ""
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
  default     = "ami-0263e4deb427da90e"

  # Validação customizada
  validation {

    /* Verifica o tamanho da string passada como sendo o AMI do recurso a ser provisionado, 
        caso for maior que 4, fará a substituição */
    condition = length(var.ec2-instance-ami) > 4 && substr(var.ec2-instance-ami, 0, 4) == "ami-"

    # Dispara a mensagem de erro
    error_message = "O valor de instance_ami deve ser um id AMI válido, inicie como \"ami-\"."
  }
}

// Tipo da instância EC2
variable "ec2-instance-number" {

  # Cada variável equivalente a um ambiente recebe a quantidade de instâncias no formato numeral
  type = object({

    dev  = number
    prod = number

  })

  description = "Quantidade de instâncias para criar"

  # ambiente dev será 1 instância e ambiente prod serão 3 instâncias
  default = {

    dev  = 1
    prod = 3

  }
}

// Tipo da instância EC2
variable "ec2-instance-type" {

  # Cada variável equivalente a um ambiente recebe a o tipo de instância no formato texto
  type = object({

    dev  = string
    prod = string

  })

  description = "Tipo de instância para criar"

  # ambiente dev será t3.micro e ambiente prod será t3.micro
  default = {

    dev  = "t3.micro"
    prod = "t3.micro"

  }
}

