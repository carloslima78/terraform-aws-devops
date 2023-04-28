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

## AWS Elastic Load Balancer (ELB)

Trata-se do recurso responsável pela distribuição de carga entre as aplicações na AWS, além de verificar a saúde das mesmas.

O Application Load Balancer (ALB) é um tipo de Elastic Load Balancer que permite rotear o tráfego da aplicação com base no conteúdo da camada de aplicação HTTP/HTTPS, como o URL da solicitação, os cabeçalhos HTTP e os métodos de solicitação. 

Em nosso projeto, estará posicionado entre o Internet Gateway e as instâncias EC2.

### Recurso Terraform (Resource): aws_lb

- Declara o provisionamento de um Elastic Load Balancer do tipo Application Load Balancer.
- Arquivo do Template no Projeto: alb.tf

## AWS Target Group

Trata-se de um grupo lógico de recursos, como instâncias EC2, containers Docker ou endereços IP, que recebem solicitações de tráfego de entrada do ALB. 

O Target Group é responsável por rotear o tráfego para as instâncias corretas, com base nas regras de roteamento definidas pelo usuário.

### Recurso Terraform (Resource): aws_lb_target_group

- Declara o provisionamento de um Target Group para o Application Load Balancer.
- Arquivo do Template no Projeto: alb.tf

## AWS Listener

Trata-se do recurso responsável por monitorar as solicitações de tráfego de entrada no ALB e encaminhá-las para o Target Group correto. O Listener é configurado com uma porta de escuta e um protocolo de transporte (HTTP, HTTPS ou TCP). 

### Recurso Terraform (Resource): aws_lb_listener

- Declara o provisionamento de um Listener para monitoramento das solicitações de tráfego de entrada.
- Arquivo do Template no Projeto: alb.tf