# Workspaces

Permite que se gerencie diferentes ambientes de maneira eficiente e organizada, garantindo que os recursos sejam implantados, gerenciados ou destruídos de forma isolada conforme um determinado ambiente.

Os workspaces são criados com o comando "terraform workspace" e podem ser listados, criados, renomeados e excluídos. 

Quando muda-se de um workspace para outro, o estado do Terraform é atualizado para refletir todas as ações para o Workspace corrente.

## Caso de Uso

Supondo que existem os ambientes de desenvolvimento e produção, é possível isolar cada um desses ambientes em Workspaces específicos, garantindo o gerenciamento segregado.

## Comandos Principais

- Lista os Workspaces existentes:

  - O Workspace "default" é o padrão caso não tenha se criado outros.

```hcl
terraform workspace list
```

- Cria um novo Workspace

```hcl
terraform workspace new dev
```

- Seleciona um Workspace, neste caso "dev":

```hcl
terraform workspace select dev 
```

- Planeja a os recursos presentes nos arquivos de um Workspace considerando o arquivo de variáveis ".tfvars":

```hcl
terraform plan -var-file=dev.tfvars 
```

- Implanta a os recursos presentes nos arquivos de um Workspace considerando o arquivo de variáveis ".tfvars":

```hcl
terraform apply -var-file=dev.tfvars -auto-approve  
```

- Destrói os recursos criados via o Workspace dev:

  - Caso esteja em outro Workspace, é necessário selecionar o que se deseja remover os recursos.

```hcl
terraform workspace select dev 
```

```hcl
terraform destroy -auto-approve
```

## Autor

[Carlos Fabiano Lima](https://github.com/carloslima78)

