

# Dispara o alarme para o Auto Scaling provisionar instâncias
resource "aws_cloudwatch_metric_alarm" "up" {

  alarm_name          = "ASG Up"
  alarm_description   = "Adiciona uma instancia quando o consumo de CPU for maior que 30%"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 30

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaleup.arn]
}

# Dispara o alarme para o Auto Scaling remover instâncias
resource "aws_cloudwatch_metric_alarm" "down" {

  alarm_name          = "ASG Down"
  alarm_description   = "Remove uma instância quando o consumo de CPU for menor que 40%"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 40

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.scaledown.arn]
}