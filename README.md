# DevOps IaaC em ambiente AWS

Estudos e projeto utilizando receitas Terraform provisionando recursos na AWS.

## IaaC

to-do

## O que é Terraform

to-do

## Equivalentes

to-do

## Instalando o Terraform no Linux Ubuntu

1. No terminal execute o comando abaixo para atualizar a lista de pacotes do sistema:

```hcl
sudo apt update
```

2. Instale o pacote curl para baixar o Terraform:

```hcl
sudo apt install curl
```

3. Baixe a versão mais recente do Terraform para o Ubuntu usando o comando curl:

```hcl
curl -LO https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
```
A versão 1.0.11pode ser diferente no momento da sua instalação. Você pode conferir a versão mais recente do Terraform em (https://www.terraform.io/downloads.html).

4. Descompacte o arquivo ZIP usando o comando abaixo:

```hcl
unzip terraform_*.zip
```

5. Mova o binário descompactado do Terraform para o diretório /usr/local/bin para que possa ser executado de forma global:

```hcl
sudo mv terraform /usr/local/bin/
```

6. Verifique se a instalação foi concluída com sucesso executando o comando abaixo:

```hcl
terraform version
```

O resultado do comando acima deve apresentar a versão instalada do Terraform conforme abaixo

```hcl
Terraform v1.3.7
on linux_amd64
```

## Comandos Básicos do Terraform

| Descrição | Comando | 
|------|-------------|
|Inicia o Terraform e instala os componentes de acordo com os recursos que serão criados| terraform init|
|Apresenta o plano dos recursos que serão criados| terraform plan| 
|Aplica a criação dos recursos conforme o "plan"| terraform apply| 
|Aplica a criação dos recursos sem solicitar confirmação | terraform apply -auto-approve| 
|Aplica a criação dos recursos considerando variáveis de ambiente | AWS_ACCESS_KEY_ID=[SUA-ACCESS-KEY] AWS_SECRET_KEY=[SUA-SECRET-KEY] terraform apply| 
|Valida os comandos presentes nos arquivos | terraform validate| 
|Formata o código dos arquivos| terraform fmt|
|Formata o código dos arquivos varrendo as estruturas de pastas| terraform fmt -recursive|
|Destrói os recursos criados| terraform destroy|

## Autor

[Carlos Fabiano Lima](https://github.com/carloslima78)

