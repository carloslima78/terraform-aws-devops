# DevOps IaaC em ambiente AWS

Estudos e projeto utilizando receitas Terraform provisionando recursos na AWS.

## Comandos Básicos

| Descrição | Comando | 
|------|-------------|
|Inicia o Terraform e instala os recursos| terraform init|
|Apresenta o plano dos recursos que serão criados| terraform plan| 
|Aplica a criação dos recursos conforme o "plan"| terraform apply| 
|Aplica a criação dos recursos sem solicitar confirmação | terraform apply -auto-approve| 
|Aplica a criação dos recursos considerando variáveis de ambiente | AWS_ACCESS_KEY_ID=SUA-[ACCESS-KEY] AWS_SECRET_KEY=[SUA-SECRET-KEY] terraform apply| 
|Valida os comandos presente nos arquivos | terraform validate| 
|Formata o código dos arquivos Terraform| terraform fmt|
|Formata o código dos arquivos Terraform varrendo as estruturas de pastas| terraform fmt -recursive|
|Destrói os recursos criados| terraform destroy|

