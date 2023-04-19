# AWS - Aplicação Serveless

## AWS Cognito

Recurso da AWS responsável pelo gerenciamento e autenticação de usuários. 

- Será utilizado o Cognito User Pools, pois os usuários serão armazenados na AWS.

### Recursos que serão declarados e criados na AWS

Declarar os resources abaixo no arquivo nomeado "cognito.tf".

1. User Pool

Módulo (module) Terraform para criar grupos de usuários do AWS Cognito, configurar seus atributos e recursos, como clientes de aplicativos, domínio, servidores de recursos.

- Documentação: (https://registry.terraform.io/modules/lgallard/cognito-user-pool/aws/latest)


2. User Pool Client

Gerencia um recurso do Cognito User Pool Client criado por outro serviço.

- Documentação: (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_managed_user_pool_client)

3. User Pool Domain

Declara o recurso (resource) Cognito User Pool Domain.

- Documentação: (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_domain)

Após configurar o arquivo "cognito.tf", executar os comandos Terraform abaixo para iniciar, planejar e aplicar os recursos declarados:

```hcl
terraform init 
```

```hcl
terraform plan 
```

```hcl
terraform apply 
```

Se tudo deu certo, teremos os recursos abaixo provisionado na AWS conforme as declarações no arquivo "cognito.tf":

- User Pool "exemplo"
- Domínio "https://api-exemplo.auth.us-east-1.amazoncognito.com"

## AWS DynamoDB