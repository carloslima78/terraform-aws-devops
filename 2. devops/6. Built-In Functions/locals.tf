// Armazena o que pode ser comum e reutilizado dentro do módulo
locals {

  # "lookup busca o valor de uma variável de acordo com a chave"
  instance_number = lookup(var.ec2-instance-number, var.environment)

  file_ext = "zip"

  object_name = "meu-arquivo-gerado-de-um-template"

  commom_tags = {

    Year  = "2023"
    Owner = "Carlos Fabiano"
  }
}