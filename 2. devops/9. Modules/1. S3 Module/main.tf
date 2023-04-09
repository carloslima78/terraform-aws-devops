
# Bucket S3 que estará presente no módulo
resource "aws_s3_bucket" "this" {

  bucket = var.name

  acl = var.acl

  policy = var.policy

  tags = var.tags

  # Web site estático que será publicado no bucket S3.
  website {

    # Página HTML principal
    index_document = "index.html"

    # Página HTML de erro
    error_document = "error.html"
  }
}

