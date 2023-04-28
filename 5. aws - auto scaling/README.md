# AWS - Aplicação Auto Escalável

Projeto de IaaC com Terraform para definição de uma infraestrutura para o provisionamento de uma aplicação auto escalável.

Serão utilizados os recursos AWS abaixo:

- AWS VPC
- AWS Internet Gateway
- AWS Subnet
- AWS Route Table
- AWS Security Group
- AWS Elastic Load Balancer
- AWS Auto Scaling
- AWS EC2
- AWS RDS

## AWS VPC (Virtual Private Cloud)

Trata-se do recurso que permite a criação de uma rede privada isolada na AWS, onde é possível provisionar e gerenciar recursos de computação, armazenamento e rede de forma segura e escalável.

### Recurso Terraform (Resource): aws_vpc

- Declara o provisionamento de uma VPC na AWS.
- Arquivo do Template no Projeto: vpc.tf

## AWS Internet Gateway

Trata-se de um componente virtual do AWS VPC (Virtual Private Cloud), que permite que instâncias de computação dentro da VPC se comuniquem com a internet. Funciona como uma ponte entre a VPC e a Internet pública, permitindo que as instâncias dentro da VPC se comuniquem com serviços na Internet pública, como servidores web, serviços de API e outros recursos na nuvem.

### Recurso Terraform (Resource): aws_internet_gateway

- Declara o provisionamento de um Internet Gateway para acesso ao VPC.
- Arquivo do Template no Projeto: vpc.tf

## AWS Subnet 

Trata-se de uma divisão lógica de uma rede IP (Internet Protocol) em sub-redes menores para ajudar a organizar e gerenciar o tráfego de rede. Restringe o acesso à uma zona de disponibilidade em uma VPC.
As subnets são altamente escaláveis e podem ser implantadas em várias zonas de disponibilidade (AZs) para aumentar a resiliência e a disponibilidade das aplicações.

### Recurso Terraform (Resource): aws_subnet

- Declara o provisionamento de uma ou mais Subnets em um VPC.
- Arquivo do Template no Projeto: vpc.tf

## AWS Route Tables 

Trata-se de tabelas contendo regras para definição de rotas de tráfego entre as Subnets dentro de uma VPC. 

### Recurso Terraform (Resource): aws_route_table

- Declara o provisionamento das Route Tables (Tabelas de Rotas) para os Subnets.
- Arquivo do Template no Projeto: vpc.tf

### Recurso Terraform (Resource): aws_route_table_association

- Declara o provisionamento uma ou mais associações entre Route Tables e Subnets.
- Arquivo do Template no Projeto: vpc.tf

## AWS Security Group

Trata-se do conjunto de regras de firewall virtual que controla o tráfego de entrada e saída de uma ou mais instâncias da AWS em uma VPC (Virtual Private Cloud). Gerencia o acesso às instâncias, permitindo que o tráfego seja permitido ou negado com base em endereços IP, portas e protocolos (HTTP, HTTPS e SSH).

### Recurso Terraform (Resource): aws_security_group

- Declara o provisionamento dos Security Groups (Grupos de Segurança) para controle de tráfego de entrada e saída.
- Arquivo do Template no Projeto: security_group.tf