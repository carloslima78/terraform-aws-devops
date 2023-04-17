locals {

  # Verifica na variável domain se existe um domínio. Caso tenha, será diferente de vazio.
  has_domain = var.domain != ""

  # Caso não se tenha um domínio personalizado, o domínio será o random_pet
  domain = local.has_domain ? var.domain : random_pet.website.id

  regional_domain = module.website.regional_domain_name

  website_filepath = "${path.module}/../website"

  common_tags = {
    Project   = "AWS com Terraform"
    Service   = "Static Website"
    CreatedAt = "2023-04-14"
    Module    = "3"
  }
}