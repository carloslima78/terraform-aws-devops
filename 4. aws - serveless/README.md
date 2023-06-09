# AWS - Aplicação Serveless

Será definida a infraestrutura Terraform para provisionamento de uma aplicação serveless para armazenamento de dados de forma síncrona via API e assíncrona via arquivos, utilizando os produtos AWS abaixo:

- AWS Cognito
- AWS API Gateway
- AWS DynamoDB
- AWS Lambda
- AWS S3
- AWS SNS
- AWS CloudWatch

## AWS Cognito

Trata-se do recurso da AWS responsável pelo gerenciamento e autenticação de usuários. 

- Será utilizado para garantir acesso seguro ao API Gateway responsável por catalogar a função Lambda que acessará a tabela DynamoDB.

### Recursos que serão declarados e criados na AWS

No arquivo Terraform "cognito.tf":

1. User Pool - aws_cognito_user_pool

-- Declara um grupo de usuários, configura seus atributos e recursos como, clientes de aplicativos, domínio, servidores de recursos, etc.

-- Documentação: (https://registry.terraform.io/modules/lgallard/cognito-user-pool/aws/latest)


2. User Pool Client - aws_cognito_user_pool_client

- Gerencia um recurso do Cognito User Pool Client criado por outro serviço.

- Documentação: (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_managed_user_pool_client)

3. User Pool Domain - aws_cognito_user_pool_domain

- Declara o recurso (resource) Cognito User Pool Domain.

- Documentação: (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain)


## AWS DynamoDB

Trata-se do banco de dados NoSQL da AWS. Bastante similar ao MongoDB, porém, com particularidades. Vale observar que a AWS disponibiza o AWS DocumentDB, que é a implemtação do MongoDB na AWS.

No escopo da nossa aplicação serveless, a tabela armazenará os dados oriundos do CRUD.

### Recursos que serão declarados e criados na AWS

No arquivo Terraform "dynamodb.tf", declaramos os recursos abaixo.

1. Tabela - aws_dynamodb_table

- Cria uma tabela no DynamoDB.

- Documentação: (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)

2. Item da Tabela - aws_dynamodb_table_item

- Cria um item a ser inserido em uma tabela no DynamoDB.

- Documentação: (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item)


## AWS Lambda

Trata-se de funções serveless para executarem ações em resposta a eventos (Triggers).

No escopo da nossa aplicação serveless, serão duas funções Lambda para realizar as regras de negócio.

### Recursos que serão declarados e criados na AWS

No arquivo Terraform "lambda.tf", declaramos os recursos abaixo.

1. [todo]

### Funão Lambda - S3

[todo]

### Funão Lambda - DynamoDB

[todo]

### Lambda Layer

Trata-se de um arquivo que contém código adicional, como bibliotecas, dependências exterbas ou até runtimes personalizados para compartilhamento entre as funções Lambda.

[todo]


## AWS S3

Trata-se ...

Será criado um bucket S3 que será responsável por disparar uma função Lambda para todo arquivo incluído, que por sua vez, dispara uma notificação para um tópico no AWS SNS e escreve um log no AWS CloudWatch.

## Criação dos Recursos da Aplicação Serveless

Após configurar os arquivos sugeridos acima, executar os comandos Terraform abaixo para iniciar, planejar e aplicar os recursos declarados:

- Inicia o Terraform e instala os componentes de acordo com os recursos declarados que serão criados:

```hcl
terraform init 
```

- Apresenta o plano dos recursos que serão criados de acordo com as receitas Terraform:

```hcl
terraform plan
```

- Aplica a criação dos recursos conforme o planejamento apresentado no "terraform plan", porém, sem solicitar confirmação:

```hcl
terraform apply -auto-approve
```

