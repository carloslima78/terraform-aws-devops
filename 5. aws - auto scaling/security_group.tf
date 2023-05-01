
# Declara o Security Group para receber as requisições que serão redirecionadas para as instâncias
resource "aws_security_group" "web" {
  name        = "Web"
  description = "Permite o trafego publico de entrada"
  vpc_id      = aws_vpc.this.id

  # Protocolo HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Protocolo HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Protocolo ICMP pra monitorar o Health Check
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Protocolo TCP para porta 3306 MySQL
  egress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private_a.cidr_block]
  }

  tags = merge(local.common_tags, { Name = "Web Server" })
}

# Declara o Security Group para receber as requisições que serão redirecionadas para a instância RDS MySQL
resource "aws_security_group" "db" {

  name        = "DB"
  description = "Permite conexoes de entrada no banco de dados"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    # Todas as instâncias dentro do Security Group "Web" terão acesso ao Secyrity Group "DB"
    security_groups = [aws_security_group.web.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Database MySQL" })
}

# Declara o Security Group para o Elastic Load Balancer
resource "aws_security_group" "alb" {
  name        = "ALB-SG"
  description = "Load Balancer SG"
  vpc_id      = aws_vpc.this.id

  # Aceitará entrada pela porta 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Aceitará saída para Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Load Balancer" })
}

# Declara o Security Group para o Auto Scaling
resource "aws_security_group" "autoscaling" {

  name        = "autoscaling"
  description = "Permite acesso de entrada e saida ssh/http as instancias EC2"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, { Name = "Auto Scaling" })
}

resource "aws_security_group" "jenkins" {
  name        = "Jenkins"
  description = "Allow incoming connections to Jenkins machine"
  vpc_id      = aws_vpc.this.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
  }

  tags = merge(local.common_tags, { Name = "Jenkins Machine" })
}