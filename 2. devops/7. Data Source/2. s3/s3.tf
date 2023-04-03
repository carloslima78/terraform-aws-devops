
// Bucket S3
resource "aws_s3_bucket" "this" {

  // Nome do Bucket que será gerado randomicamente declarado no arquivo "random.tf"
  bucket = "${random_pet.bucket.id}"
}

// Objeto que será armazenado no Bucket S3
resource "aws_s3_bucket_object" "this" {

  // Referencia o bucket acima
  bucket = aws_s3_bucket.this.bucket

  // Local onde salvará o arquivo no bucket pegando o valor definido no arquivo locals.tf
  key = "instances/instances-${local.instance.ami}.json"

  // Origem do arquivo pegando o valor definido no arquivo locals.tf
  source = "outputs.json"

  etag = filemd5("outputs.json")

  content_type = "application/zip"
}