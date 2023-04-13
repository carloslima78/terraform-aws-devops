# Workspaces

Permite que se gerencie diferentes ambientes de maneira eficiente e organizada, garantindo que os recursos sejam implantados, gerenciados ou destruídos de forma isolada conforme um determinado ambiente.

Os workspaces são criados com o comando "terraform workspace" e podem ser listados, criados, renomeados e excluídos. 

Quando muda-se de um workspace para outro, o estado do Terraform é atualizado para refletir todas as ações para o Workspace corrente.

## Caso de Uso

Supondo que existem os ambientes de desenvolvimento e produção, é possível isolar cada um desses ambientes em Workspaces específicos, garantindo o gerenciamento segregado.

## Passo a Passo - Mão na Massa

1. Crie dois Workspaces, sendo um para desenvolvimento e outro para produção:

```hcl
terraform workspace new dev
```

```hcl
terraform workspace new prod
```

2. Crie o arquivo "main.tf" contendo as configurações para duas instâncias EC2:

```hcl
terraform {

  required_version = ">=1.3.7"

  # Loca o Provider AWS
  required_providers {

    aws = {

      # Dados da origem e versão, encontrados no arquivo ".terraform.lock.hcl"
      source  = "hashicorp/aws"
      version = "4.58.0"

    }
  }
}

# Região
provider "aws" {

  region = "us-east-1"
}

# Configurações da instância EC2 para o ambiente de desenvolvimento
resource "aws_instance" "web-dev" {
  ami           = "ami-0263e4deb427da90e"
  instance_type = "t2.micro"
}

# Configurações da instância EC2 para o ambiente de produção
resource "aws_instance" "web-prod" {
  ami           = "ami-0263e4deb427da90e"
  instance_type = "t3.micro"
}
```

3. Crie dois arquivos separados "dev.tfvars" e "prod.tfvars" e defina as variáveis conforme abaixo:

```hcl
# dev.tfvars
instance_count = 2

instance_tags = {
  
  name = "web-dev"
}

# prod.tfvars
instance_count = 3

instance_tags = {
  
  name = "web-prod"
}
```

4. Conforme os comandos abaixo, selecione o Workspace desejado e crie os recursos conforme o ambiente de desenvolvimento e produção:

```hcl
# Seleciona o workspace dev
terraform workspace select dev 

# Planeja a configuração de desenvolvimento
terraform apply -var-file=dev.tfvars 

# Implanta a configuração de desenvolvimento
terraform apply -var-file=dev.tfvars  
```

```hcl
# Seleciona o workspace prod
terraform workspace select prod 

# Planeja a configuração de produção
terraform apply -var-file=prod.tfvars 

# Implanta a configuração de produção
terraform apply -var-file=prod.tfvars  
```