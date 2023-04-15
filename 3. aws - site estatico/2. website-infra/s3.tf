
# Data para definir a Policy de acesso ao Bucket de fora da AWS.
data "template_file" "s3-public-policy" {

  # A Policy está definida em um arquivo .json de template.
  template = file("policy.json")

  vars = {

    bucket_name = local.domain

  }
}

# Módulo para o Bucket onde serão armazenado os Logs do Website.
module "logs" {

  source        = "github.com/chgasparoto/terraform-s3-object-notification"
  name          = "${local.domain}-logs"
  acl           = "log-delivery-write"
  force_destroy = !local.has_domain
}

# Módulo para o Bucket onde serã hospedado o Website.
module "website" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification"
  name          = local.domain
  acl           = "public-read"
  policy        = data.template_file.s3-public-policy.rendered
  force_destroy = !local.has_domain
  tags          = local.common_tags

  versioning = {
    enabled = true
  }

  filepath = "${local.website_filepath}/build"
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  logging = {
    target_bucket = module.logs.name
    target_prefix = "access/"
  }
}

# Módulo para redirecionamento.
module "redirect" {
  source        = "github.com/chgasparoto/terraform-s3-object-notification"
  name          = "www.${local.domain}"
  acl           = "public-read"
  force_destroy = !local.has_domain
  tags          = local.common_tags

  website = {
    redirect_all_requests_to = local.has_domain ? var.domain : module.website.website
  }
}