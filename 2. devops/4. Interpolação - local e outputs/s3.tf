// Bucket S3
resource "aws_s3_bucket" "this" {

  //  Nome do Bucket que será gerado randomicamente declarado no arquivo "random.tf"
  bucket = "${random_pet.bucket.id}"

  // Tags que será atribúidas a partir do arquivo locals.tf
  tags = local.commom_tags
}

// Objeto que será armazenado no Bucket S3
resource "aws_s3_bucket_object" "this" {

    // Referencia o bucket acima
    bucket = aws_s3_bucket.this.bucket

    // Local onde salvará o arquivo no bucket pegando o valor definido no arquivo locals.tf
    key = "${local.target_file_path}"

    // Origem do arquivo pegando o valor definido no arquivo locals.tf
    source = "${local.source_file_path}"  
}