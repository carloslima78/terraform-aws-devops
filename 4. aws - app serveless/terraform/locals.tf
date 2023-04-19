
locals {
  lambdas_path = "${path.module}/../app/lambdas"
  layers_path  = "${path.module}/../app/layers/nodejs"
  layer_name   = "joi.zip"

  common_tags = {
    Project   = "Aplicação Serveless"
    CreatedAt = "2023-04-18"
    ManagedBy = "Terraform"
    Owner     = "Carlos Fabiano Lima"
    Service   = var.service_name
  }
}