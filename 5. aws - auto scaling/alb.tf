
# Declara um Application Load Balancer
resource "aws_lb" "this" {
  
  name            = "Terraform-ALB"
  security_groups = [aws_security_group.alb.id]
  subnets         = [aws_subnet.public_a.id, aws_subnet.public_b.id]

  tags = merge(local.common_tags, { Name = "Terraform ALB" })
}

# Declara um target group para o Application Load Balancer
resource "aws_lb_target_group" "this" {
  
  name     = "ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id

  health_check {
    path              = "/"
    healthy_threshold = 2
  }
}

# Declara um listener para monitorar a saúde do Application Load Balancer
resource "aws_lb_listener" "this" {
  
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

    # Encaminha as requisições para o Target Group
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}