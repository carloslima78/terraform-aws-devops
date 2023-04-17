# Site Estático na AWS

## Aplicação React para Exemplo

Trata-se de uma aplicação React de exemplo disponibilizada pela comunidade para que seja utilizada para testes.

Repositório GitHub (https://github.com/facebook/create-react-app)

### Instalação da Aplicação React 

O comando de instalação deve ser executado dentro da pasta onde a aplicação será instalada.

- Comando para instalar a aplicação:

```hcl
npx create-react-app my-app
```

- Comando para acessar a pasta onde a aplicação foi instalada:

Execute caso não esteja na pasta.

```hcl
cd my-app
```

- Comando para inicialiar a aplicação, que será executada na URL local "http://localhost:3000/:

```hcl
npm start
```

- Comando para criar um "build" para gerar um pacote para publicação em ambiente de produção:

```hcl
npm run build
```

- Para sair da aplicação em execução, basta pressionar "Ctrl + C". 

## Bucket S3 e Tabela DynamoDB - BackEnd Remote State

Neste passo, será criada a infraestrutura para armazenamento do estado (Remote State) da aplicação React que será hospedata. Provisionaremos um bucket S3 e uma tabela no DynamoDB.

[todo]

## Bucket S3 - Hospedagem da Aplicação React


- Caso o arquivo "terraform.lock.hcl" responsável pelas autalizações de estado já tenha sido criado, o Terraform passa a barrar novas criações, portanto, neste caso, executar "plan" e "apply" utilizando o parâmetro "-lock=false", porém, isso não é aconselhável.

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


## AWS CloudFront

Trata-se do recurso CDN (Content Delivery Network) utilizado para reduzir a latência de chamadas em aplicações hospedadas na AWS, realizando deployments em locais mais próximos georgraficamente dos possíveis acessos. Esses locais são conhecidos como "Edge Locations".

1. Criar o arquivo cloudfront.tf para codificação da receita Terraform:

2. Implementar o código para criação do recurso AWS CloudFront:

3. Executar os comandos para abaixo para criação do recurso AWS CloudFront:

```hcl
terraform init
```

```hcl
terraform plan
```

```hcl
terraform apply -auto-approve
```

Caso e execução tenha sido com sucesso, a AWS vai criar o CloudFront logo a URL da sua distribuição CDN que apontará para a aplicação React, que passará a estar hospedata também nas Edge Locations.

O resultado deve ser uma URL do CloudFront conforme abaixo, neste caso está sendo impressa em um Terraform Output:

- cdn-url = "d3up9r9i7rtzis.cloudfront.net"

##  AWS Route 53

[todo]

##  Certificado SSL (ACM)

[todo]


## Autor

[Carlos Fabiano Lima](https://github.com/carloslima78)


