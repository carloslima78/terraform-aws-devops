
locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  common_tags = {
    Project   = "AWS com Terraform"
    CreatedAt = "2023-03-17"
    ManagedBy = "Terraform"
    Owner     = "Carlos Fabiano Lima"
    Service   = "Auto Scaling"
  }
}