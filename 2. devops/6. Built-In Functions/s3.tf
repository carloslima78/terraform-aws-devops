// Bucket S3
resource "aws_s3_bucket" "this" {

  //  Nome do Bucket que será gerado randomicamente declarado no arquivo "random.tf"
  bucket = "${random_pet.bucket.id}-${var.environment}"

  // Tags que será atribúidas a partir do arquivo locals.tf
  tags = local.commom_tags
}

// Objeto que será armazenado no Bucket S3
resource "aws_s3_bucket_object" "this" {

  // Referencia o bucket acima
  bucket = aws_s3_bucket.this.bucket

  // Local onde salvará o arquivo no bucket pegando o valor definido no arquivo locals.tf
  key = "${uuid()}.${local.file_ext}"

  // Origem do arquivo pegando o valor definido no arquivo locals.tf
  source = data.archive_file.json.output_path

  etag = filemd5(data.archive_file.json.output_path)

  content_type = "application/zip"
}