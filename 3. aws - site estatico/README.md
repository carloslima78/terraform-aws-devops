# Site Estático na AWS

Neste projeto, uma aplicação React de exemplo será hospedada em um bucket S3 e uma distribuição CDN do CloudFront será atribuída.

## Aplicação React para Exemplo

Trata-se de uma aplicação React de exemplo disponibilizada pela comunidade para que seja utilizada para testes. 

Repositório GitHub (https://github.com/facebook/create-react-app)

Esta será a aplicação hospedada no bucket S3.


### Passos para instalação da aplicação React 

1. Criar uma pasta para hospedagem local da aplicação após instalação:

- Comando para criar a pasta onde a aplicação foi instalada:

```hcl
mkdir website
```

2. Acessar a pasta criada para instalação da aplicação:

- Comando para acessar a pasta onde a aplicação foi instalada:

```hcl
cd website
```

3. Executar a instalação da aplicação:

- O comando de instalação deve ser executado dentro da pasta onde a aplicação será instalada.

- Comando para instalar a aplicação:

```hcl
npx create-react-app website
```
Ao realizar o comando acima, a aplicação será instalada em ambiente local.

4. Executar a aplicação:

- Comando para inicialiar a aplicação, que será executada na URL local e porta 3000 (http://localhost:3000/):

```hcl
npm start
```
 5. Sair da execução da aplicação:

- Para sair da aplicação em execução, basta pressionar "Ctrl + C". 


## Terraform BackEnd - Remote State

Neste passo, será criada a infraestrutura para armazenamento do estado (Remote State) da aplicação React que será hospedada. 

1. Na pasta "1. backend-state", criar o arquivo "main.tf" declarando um Bucket S3 e uma tabela DynamoDB para armazenamento e gestão de estado.

2. Acessar a pasta "1. backend-state" e executar os comandos abaixo:

```hcl
terraform init -backend=true -backend-config="backend.hcl"
```

```hcl
terraform plan -lock=false
```

```hcl
terraform apply -auto-approve -lock=false
```

Conforme o arquivo main.tf e os comandos acima, será criado um backend para armazenamento de estado.


## Terraform Buckets S3 - Hospedagem, Redirecionamento e Logs

Neste passo, será criado os bucket S3 para hospedagem, redirecionamento e logs da aplicação:

- Criar o build para gerar o pacote de publicação da aplicação no bucket S3:

-- Acessar a pasta "website" onde a aplicação foi instalada:

```hcl
cd website
```

- Dentro da pasta "website" executar o comando para criar o "build":

```hcl
npm run build
```

- Os arquivos Terraform abaixo, são necessários para hospedagem da aplicação:

-- main.tf: Declara os providers, backend e random_pet para nomear o website da aplicação.
-- s3.tf: Declara os módulos para os buckets de redirecionamento, hospedagem e logs.
-- locals.tf: Preenche as variáveis comuns.
-- outputs.tf: Imprime as saídas após execução.
-- variables.tf: Declara as variáveis comuns.

-- policy.json: Contém a "IAM Policy" para permitir a leitura no bucket S3 onde a aplicação estará hospedada. 


## AWS CloudFront

Trata-se do recurso CDN (Content Delivery Network) utilizado para reduzir a latência de chamadas em aplicações hospedadas na AWS, realizando deployments em locais mais próximos georgraficamente dos possíveis acessos. Esses locais são conhecidos como "Edge Locations".

1. O arquivo Terraform abaixo, é necessário para declarar uma distribuição CDN para o bucket S3 que hospeda a aplicação:

- cloudfront.tf

Caso e execução tenha sido com sucesso, a AWS vai criar o CloudFront logo a URL da sua distribuição CDN que apontará para a aplicação React, que passará a estar hospedata também nas Edge Locations.

O resultado deve ser uma URL do CloudFront conforme abaixo, neste caso está sendo impressa em um Terraform Output:

- cdn-url = "d3up9r9i7rtzis.cloudfront.net"


##  AWS Route 53

Trata-se do serviço da AWS para gerenciamento de DNS (Domain Name System) que é responsável pelo monitoramento de servidores para roteamento de tráfego.

- O arquivo Terraform abaixo, é necessário para declarar os recursos necessários para gestão e roteamento de DNS da aplicação:

-- route53.tr: 

Vale observar que caso não se tenha um domínio registrado, os recursos declarados não serão criados.


##  Certificado SSL (ACM)

Trata-se do serviço da AWS para gerenciamento de certificados SSL.

- O arquivo Terraform abaixo, é necessário para declarar os recursos para gerar e verificar certificados SSL.

-- acm.tf


##  Criação dos Recursos 

Neste passo, os recursos declarados acima serão criados.

- Caso o arquivo "terraform.lock.hcl" responsável pelas autalizações de estado já tenha sido criado, o Terraform passa a barrar novas criações, portanto, neste caso, executar "plan" e "apply" utilizando o parâmetro "-lock=false", porém, isso não é aconselhável. Caso contrário, executar os comandos abaixo sem o parâmetro "-lock=false".

```hcl
terraform init -backend=true -backend-config="backend.hcl"
```

```hcl
terraform plan -lock=false
```

```hcl
terraform apply -auto-approve -lock=false
```

Caso e execução tenha sido com sucesso, a AWS vai gerar a URL que apontará para a aplicação React hospedada no bucket S3!

O resultado deve ser uma URL conforme abaixo, neste caso está sendo impressa em um Terraform Output:

- website-url = "hopefully-generally-similarly-musical-sculpin.s3-website-us-east-1.amazonaws.com"


## Autor

[Carlos Fabiano Lima](https://github.com/carloslima78)


