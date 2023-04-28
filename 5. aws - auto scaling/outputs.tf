
output "vpc_id" {
  value = aws_vpc.this.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}

output "public_subnet_a" {
  value = aws_subnet.public_a.id
}

output "public_subnet_b" {
  value = aws_subnet.public_b.id
}

output "private_subnet_a" {
  value = aws_subnet.private_a.id
}

output "private_subnet_b" {
  value = aws_subnet.private_b.id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "route_table_assossiation_public_a" {
  value = aws_route_table_association.public_a_association.id
}

output "route_table_assossiation_public_b" {
  value = aws_route_table_association.public_b_association.id
}

output "route_table_assossiation_private_a" {
  value = aws_route_table_association.private_a_association.id
}

output "route_table_assossiation_private_b" {
  value = aws_route_table_association.private_b_association.id
}


# output "route_table_assossiation_ids" {
#   value = [for k, v in aws_route_table_association.this : v.id]
# }

output "sg_web_id" {
  value = aws_security_group.web.id
}

output "sg_db_id" {
  value = aws_security_group.db.id
}

# output "sg_alb_id" {
#   value = aws_security_group.alb.id
# }

# output "alb_id" {
#   value = aws_lb.this.id
# }