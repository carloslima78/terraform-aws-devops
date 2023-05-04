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
- AWS CloudWatch
- AWS EC2
- AWS RDS

## AWS VPC (Virtual Private Cloud)

Trata-se do recurso que permite a criação de uma rede privada isolada na AWS, onde é possível provisionar e gerenciar recursos de computação, armazenamento e rede de forma segura e escalável.

No escopo do projeto, será a rede privada para a aplicação auto escalável.

### Recurso Terraform (Resource): **aws_vpc**

- Declara o provisionamento de uma VPC na AWS.
- Arquivo do Template no Projeto: **vpc.tf**

## AWS Internet Gateway

Trata-se de um componente virtual do AWS VPC (Virtual Private Cloud), que permite que instâncias de computação dentro da VPC se comuniquem com a internet. Funciona como uma ponte entre a VPC e a Internet pública, permitindo que as instâncias dentro da VPC se comuniquem com serviços na Internet pública, como servidores web, serviços de API e outros recursos na nuvem.

No escopo do projeto, será a porta de entrada para a rede privada VPC.

### Recurso Terraform (Resource): **aws_internet_gateway**

- Declara o provisionamento de um Internet Gateway para acesso ao VPC.
- Arquivo do Template no Projeto: **vpc.tf**

## AWS Subnet 

Trata-se de uma divisão lógica de uma rede IP (Internet Protocol) em sub-redes menores para ajudar a organizar e gerenciar o tráfego de rede. Restringe o acesso à uma zona de disponibilidade em uma VPC.

As subnets são altamente escaláveis e podem ser implantadas em várias zonas de disponibilidade (AZs) para aumentar a resiliência e a disponibilidade das aplicações.

No escopo do projeto, teremos duas subnets públicas para isolamento das instâncias que receberão tráfego da internet e duas subnets privadas para isolamento das instâncias que receberão tráfego interno.

### Recurso Terraform (Resource): **aws_subnet**

- Declara o provisionamento de uma ou mais Subnets em um VPC.
- Arquivo do Template no Projeto: **vpc.tf**

## AWS Route Tables 

Trata-se de tabelas contendo regras para definição de rotas de tráfego entre as Subnets dentro de uma VPC. 

### Recurso Terraform (Resource): **aws_route_table**

- Declara o provisionamento das Route Tables (Tabelas de Rotas) para os Subnets.
- Arquivo do Template no Projeto: **vpc.tf**

### Recurso Terraform (Resource): aws_route_table_association

- Declara o provisionamento das associações entre Route Tables com as Subnets.
- Arquivo do Template no Projeto: **vpc.tf**

## AWS Security Group

Trata-se do conjunto de regras de firewall virtual que controla o tráfego de entrada e saída de uma ou mais instâncias da AWS em uma VPC (Virtual Private Cloud). Gerencia o acesso às instâncias, permitindo que o tráfego seja permitido ou negado com base em endereços IP, portas e protocolos (HTTP, HTTPS e SSH).

### Recurso Terraform (Resource): **aws_security_group**

- Declara o provisionamento dos Security Groups (Grupos de Segurança) para controle de tráfego de entrada e saída.
- Arquivo do Template no Projeto: **security_group.tf**

## AWS Elastic Load Balancer (ELB)

Trata-se do recurso responsável pela distribuição de carga entre as aplicações na AWS, além de verificar a saúde das mesmas.

O Application Load Balancer (ALB) é um tipo de Elastic Load Balancer que permite rotear o tráfego da aplicação com base no conteúdo da camada de aplicação HTTP/HTTPS, como o URL da solicitação, os cabeçalhos HTTP e os métodos de solicitação. 

Em nosso projeto, estará posicionado entre o Internet Gateway e as instâncias EC2.

### Recurso Terraform (Resource): **aws_lb**

- Declara o provisionamento de um Elastic Load Balancer do tipo Application Load Balancer.
- Arquivo do Template no Projeto: **alb.tf**

## AWS Target Group

Trata-se de um grupo lógico de recursos, como instâncias EC2, containers Docker ou endereços IP, que recebem solicitações de tráfego de entrada do Application Load Balancer. 

O Target Group é responsável por rotear e distribuir o tráfego para as instâncias corretas dentro do grupo (Target Group), com base nas regras de roteamento definidas pelo usuário.

### Recurso Terraform (Resource): **aws_lb_target_group**

- Declara o provisionamento de um Target Group para o Application Load Balancer.
- Arquivo do Template no Projeto: **alb.tf**

## AWS Listener

Trata-se do recurso responsável por monitorar as solicitações de tráfego de entrada no Application Load Balancer e encaminhá-las para o Target Group correto. O Listener é configurado com uma porta de escuta e um protocolo de transporte (HTTP, HTTPS ou TCP). 

### Recurso Terraform (Resource): **aws_lb_listener**

- Declara o provisionamento de um Listener para monitoramento das solicitações de tráfego de entrada.
- Arquivo do Template no Projeto: **alb.tf**

## AWS Auto Scaling

Trata-se do recurso que garante a disponibilidade e escalabilidade das aplicações de forma automática, de acordo com as necessidades de demanda e tráfego dos usuários.

### AWS Auto Scaling Group

Trata-se do recurso responsável pelo gerenciamento da quantidade de instâncias EC2 em execução, ajustando-o de acordo com as métricas de desempenho da aplicação ou com base em horários específicos definidos pelo usuário. 

O Auto Scaling Group permite que o número de instâncias em execução aumente ou diminua de acordo coma demadna, garantido que as aplicações estejam disponíveis e eficiêntes.


#### Auto Scaling Group vs Target Group

O **Auto Scaling Group** atua junto ao **Auto Scaling** e é responsável pelo gerenciamento da infraestrutura de computação que executa a aplicação, enquanto o **Target Group** atua junto ao **Application Load Balancer** e é responsável pelo direcionamento do tráfego de rede para as instâncias corretas.

### Recurso Terraform (Data): ** aws_ami **

- Declara a imagem (AMI) Ubuntu para a instância EC2 que será provisionada.
- Arquivo do Template no Projeto: **ec2.tf**

### Recurso Terraform (Resource): ** aws_launch_template **

- Define o template personalizado para provisionamento da instância EC2.
- Arquivo do Template no Projeto: **ec2.tf**

### Recurso Terraform (Resource): ** aws_autoscaling_group **

- Declara o provisionamento do Auto Scaling Group para gerenciamento da infraestrutura.
- Arquivo do Template no Projeto: **ec2.tf**

### Recurso Terraform (Resource): ** aws_autoscaling_policy **

- Declara o provisionamento das políticas necessárias para que o Auto Scaling seja capaz de provisionar e remover instâncias EC2.
- Arquivo do Template no Projeto: **ec2.tf**

## AWS CloudWatch

Trata-se do recurso da AWS para monitoramento e observabilidade que permite coletar e monitorar métricas, logs e eventos para serviços da AWS tais como instâncias EC2, balanceadores de carga, bancos de dados RDS, filas SQS, etc.

## AWS CloudWatch Alarm

Trata-se do recurso que permite monitorar recursos e aplicativos na AWS baseado em métricas, e definir alarmes para notificações quando essas métricas atingirem os limites predefinidos. 

### Recurso Terraform (Resource): ** aws_cloudwatch_metric_alarm **

- Declara o provisionamento dos alarmes para estimular o Auto Scaling a provisionar (UP) ou remover (Down) instâncias conforme demanda de processamento.
- Arquivo do Template no Projeto: **cloudwatch.tf**

## Provisionamento dos Recursos

Serão apresentados os comandos Terraform para provisionar os recursos explicados acima e presentes nos arquivos do projeto.

### Comandos Terraform

- Inicia o Terraform e instala os componentes de acordo com os recursos declarados:

```hcl
terraform init 
```

- Formata e identa o código presente nos arquivos Terraform (Comando Opcional):

```hcl
terraform fmt 
```

- Valida o código e comandos presentes nos arquivos Terraform (Comando Opcional):

```hcl
terraform validate 
```

- Apresenta o plano dos recursos que serão provisionados de acordo com os arquivos Terraform:

```hcl
terraform plan
```

- Aplica o provisionamento (criação) dos recursos na AWS conforme o planejamento:

```hcl
terraform apply -auto-approve
```

## Testando a Aplicação Auto Escalável

[TO DO]