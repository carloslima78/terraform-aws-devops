# DevOps IaaC em ambiente AWS

Estudos e projeto utilizando receitas Terraform provisionando recursos na AWS.

## IaaC

to-do

## O que é Terraform

to-do

## Equivalentes

Segue abaixo, algumas ferramentas equivalentes ao Terraform:

- AWS: CloudFormation, CDK (Cloud Development Kit).
- Azure: Azure Resource Manager (ARM), Bicep.
- Google Cloud Platform (GCP): Deployment Manager.

As ferramentas descritas acima, tratam-se de produtos acoplados a um fornecedor de nuvem, e assim como o Terraform, existem outras opções disponíveis de IaaC que são agnósticas a fornecedores, como Ansible, Chef, Puppet, SaltStack, entre outras.

Vale observar que a utilização do Terraform em ambientes AWS, Azure, GCP, etc, evita o lock in e viabiliza operações multi cloud.

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

- Obs: A versão 1.0.11pode ser diferente no momento da sua instalação. Você pode conferir a versão mais recente do Terraform em (https://www.terraform.io/downloads.html).


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

O resultado do comando acima deve apresentar a versão instalada do Terraform conforme abaixo:

```hcl
Terraform v1.3.7
on linux_amd64
```

## Comandos Básicos do Terraform


- Apresenta a documentação dos comandos Terraform:

```hcl
terraform -h 
```

- Inicia o Terraform e instala os componentes de acordo com os recursos que serão criados:

```hcl
terraform init 
```

- Apresenta o plano dos recursos que serão criados de acordo com as receitas Terraform:

```hcl
terraform plan
```

- Aplica a criação dos recursos conforme o planejamento apresentado no "terraform plan":

```hcl
terraform apply
```

- Aplica a criação dos recursos conforme o planejamento apresentado no "terraform plan", porém, sem solicitar confirmação:

```hcl
terraform apply -auto-approve
```

- Aplica a criação dos recursos conforme o planejamento apresentado no "terraform plan", considerando variáveis de ambiente, caso tenham sido criadas:

    - No exemplo abaixo, considera-se as variáveis de ambiente para credenciais de acesso de usuário IAM da AWS.

```hcl
AWS_ACCESS_KEY_ID=[tua-access-key] AWS_SECRET_KEY=[tua-secret-key] terraform apply
```

- Realiza a validação dos comandos presentes nos arquivos Terraform:

```hcl
terraform validate
```

- Realiza a formatação (identação) dos códigos presentes nos arquivos Terraform:

```hcl
terraform fmt
```

- Realiza a formatação (identação) dos códigos presentes nos arquivos Terraform, porém, de forma recursiva caso os arquivos estejam em uma estrutura hierarquica de pastas:

```hcl
terraform fmt -recursive
```

- Destrói os recursos criados no ambiente AWS:

```hcl
terraform destroy 
```

## Autor

[Carlos Fabiano Lima](https://github.com/carloslima78)

