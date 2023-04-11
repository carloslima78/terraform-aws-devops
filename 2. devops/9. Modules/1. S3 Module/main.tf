
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
}

module "object" {

  source = "../3. S3 Object"
}

