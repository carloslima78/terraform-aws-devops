
# Nomeará o bucket
resource "random_pet" "bucket" {}

# Declara o bucket s3
resource "aws_s3_bucket" "todo" {

  bucket = "${var.service_domain}-${random_pet.bucket.id}"
  tags   = local.common_tags
}

# Declara uma notificação do bucket s3 invocando a função Lambda.
resource "aws_s3_bucket_notification" "lambda" {

  bucket = aws_s3_bucket.todo.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3.arn

    # Escutará qualquer tipo de arquivo que for incluído no bucket. É possível filtrar (.jpg, .json, etc.)
    events = ["s3:ObjectCreated:*"]
  }
}