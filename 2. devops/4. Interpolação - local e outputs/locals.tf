
// Armazena o que pode ser comum e reutilizado dentro do módulo
locals {
  
  source_file_path = "/home/carlos/Documents/Fontes - Projetos/AWS/Terraform/2. Terraform DevOps AWS/Notas.txt"

  target_file_path = "minha-pasta/Notas.txt"

  commom_tags = {

    Service     = "Estudo Terraform"
    ManagedBy   = "AWS e Terraform"
    Environment = var.environment
    Owner       = "Carlos Fabiano"
  }
}