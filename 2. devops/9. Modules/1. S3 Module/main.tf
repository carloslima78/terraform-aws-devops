
# Bucket S3 que estará presente no módulo
resource "aws_s3_bucket" "this" {

  bucket = var.name

  acl = var.acl

  policy = var.policy

  tags = var.tags

  # Bloco dinâmico referente ao Website
  dynamic "website" {
    
    # Percorre as keys da variável "website" que é um map
    for_each = length( keys(var.website)) == 0 ? [] : [var.website]

    content {
      
      # Página HTML principal
      index_document = lookup(website.value, "index_document", null)

      # Página HTML de erro
      error_document = lookup(website.value, "error_document", null)

      redirect_all_requests_to = lookup(website.value, "redirect_all_requests_to", null)

      routing_rules = lookup(website.value, "routing_rules", null)
    }
  }

  # Bloco dinâmico referente ao versionamento
  dynamic "versioning" {
    
    # Percorre as keys da variável "versioning" que é um map
    for_each = length( keys(var.versioning)) == 0 ? [] : [var.versioning]

    content {
      
      enabled = lookup(versioning.value, "enabled", null)

      mfa_delete = lookup(versioning.value, "mfa_delete", null)

    }
  }

}

module "objects" {

  source = "./1. S3 Object"

  for_each = var.files != "" ? fileset(var.files, "**") : []

  bucket = aws_s3_bucket.this.bucket
  key    = "${var.key_prefix}/${each.value}"
  src    = "${var.files}/${each.value}"

}



