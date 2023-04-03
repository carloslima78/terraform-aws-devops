
data "terraform_remote_state" "server" {

    backend = "s3"

    // Configuração de acesso ao Remote State no Bucket S3
    config = {

        # Nome do Bucket
        bucket = "tfstate-303315406913"

        # Prefixo onde será salvo o arquivo no Bucket
        key = "Dev/usando-data-source/terraform.tfstate"

        # Região
        region = var.aws-region 
    }
}