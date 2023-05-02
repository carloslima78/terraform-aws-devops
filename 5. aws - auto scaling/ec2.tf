
# Data Source com a imagem (AMI) da instância EC2 que será provisionada.
data "aws_ami" "ubuntu" {

  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Define o template personalizado para provisionamento da instância EC2
resource "aws_launch_template" "this" {

  name_prefix   = "terraform-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.instance_key_name

  # Executará os comandos de instalação do Apache presentes no arquivo ec2_setup.sh na instância EC2.
  user_data = filebase64("ec2_setup.sh")

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.autoscaling.id]
  }
}

# Declara um Auto Scaling Group 
resource "aws_autoscaling_group" "this" {

  name                = "terraform-autoscaling"
  vpc_zone_identifier = [aws_subnet.public_a.id, aws_subnet.public_a.id]
  max_size            = 5
  min_size            = 2

  # Checagem por 4 minutos
  health_check_grace_period = 240
  health_check_type         = "ELB"
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.this.id]

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }
}

# Declara as políticas para que o Auto Scaling seja capaz de provisionar instâncias EC2
resource "aws_autoscaling_policy" "scaleup" {

  name                   = "Scale Up"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"

  # Adiciona uma instância EC2
  scaling_adjustment = "1"

  # Aguarda 3 minutos para checagem de escala
  cooldown    = "180"
  policy_type = "SimpleScaling"
}

# Declara as políticas para que o Auto Scaling seja capaz de desligar/remover instâncias EC2
resource "aws_autoscaling_policy" "scaledown" {
  name                   = "Scale Down"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type        = "ChangeInCapacity"

  # Remove uma instância EC2
  scaling_adjustment = "-1"

  # Aguarda 3 minutos para checagem de remoção
  cooldown    = "180"
  policy_type = "SimpleScaling"
}

resource "aws_instance" "jenkins" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.jenkins.id]
  subnet_id              = aws_subnet.private_b.id
  availability_zone      = "${var.aws_region}b"

  tags = merge(local.common_tags, { Name = "Jenkins Machine" })
}