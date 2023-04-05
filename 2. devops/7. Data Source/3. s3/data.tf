
data "terraform_remote_state" "server" {

  // Tipo de backend onde será armazenado o remote_state ".tfstate"
  backend = "s3"

  // Configuração de acesso aos dados do remote_state da instância EC2 de origem.
  config = {

    # Nome do Bucket
    bucket = "tfstate-303315406913"

    # Prefixo onde será salvo o arquivo no Bucket
    key = "dev/usando-data-source/terraform.tfstate"

    # Região
    region = "us-east-1"
  }
}