# AWS S3 Terraform module

Módulo para provisionar um bucket S3 com três objetos na AWS.

Tipos de recursos suportados:

* [S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
* [S3 Bucket Object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object)

## Utilização

```hcl
module "bucket" {
  source = "./1. S3 Module"

  name = "my-super-bucket-name"
}
```

## Exemplos

```hcl
module "bucket" {
  source = "./1. S3 Module"

  name  = random_pet.this.id
  files = "${path.root}/website"

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```

## Criação


## Inputs

| Nome | Descrição | Tipo | Default | Requerido |
|------|-------------|:----:|:-----:|:-----:|
|name|Nome único do bucket|string|null| ✅ |
|acl|ACL do bucket|string|private|  |
|files|Pasta para ler e transmitir o arquivo para o bucket|string|null|  |

## Outputs

| Nome | Descrição |
|------|-------------|
|name|Nome do bucket|
|arn|ARN do bucket|
|files|Lista de arquivos transmitidos para o bucket|



## Autor

[Carlos Fabiano Lima](https://github.com/carloslima78)

