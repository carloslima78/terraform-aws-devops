
# Variável contendo a região onde os recursos AWS serão providionados
variable "aws_region" {
  type        = string
  description = ""
  default     = "eu-central-1"
}

# Variável contendo o número da conta AWS
variable "aws_account_id" {
  type        = number
  description = ""
  default     = 303315406913
}

# Variável contendo o nome do serviço
variable "service_name" {
  type        = string
  description = ""
  default     = "autoscaling-app"
}

# Variável contendo o tipo de instância EC2
variable "instance_type" {
  type        = string
  description = ""
  default     = "t3.micro"
}

# Variável contendo o nome do par de chaves para EC2 (Key Pair)
variable "instance_key_name" {
  type        = string
  description = ""
  default     = "carlos_kp"
}