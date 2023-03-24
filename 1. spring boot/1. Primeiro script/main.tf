terraform{
    required_version = ">=1.3.7"

}

provider "aws" {
    region = "us-east-1"
}

// Bucket S3
resource "aws_s3_bucket" "terraform-buckets3-teste" {
    bucket = "meu-bucket"
    acl = "private"
}

// Instância EC2
resource "aws_instance" "terraform-ec2-teste"{
    ami = "ami-0263e4deb427da90e"
    instance_type = "t2.micro"
}

// Security Group permitindo acesso a porta 5432
resource "aws_security_group" "terraform-security-group-postgres" {
  name_prefix = "postgres-"
  description = "Security group para PostgreSQL"
  vpc_id      = "vpc-0905a9f9e73aa8b3c"

  ingress {
    from_port = 0
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

    // Usando o recurso de Tag para especificar o tipo Postgres
   tags = {
    Name = "postgres"
  }

}

// Instância RDS Postgres com um Security Group associado.
resource "aws_db_instance" "terraform-banco-postgres"{
    allocated_storage =  20 
    storage_type = "gp2"
    engine = "postgres"
    engine_version = "12.10"
    instance_class = "db.t2.micro"
    name = "meubancopostgres"
    username = "postgres"
    password = "postgres"
    publicly_accessible  = true
    vpc_security_group_ids = [aws_security_group.terraform-security-group-postgres.id]
}

// Fila SQS
resource "aws_sqs_queue" "terraform-queue" {
  name = "terraform-queue"
}