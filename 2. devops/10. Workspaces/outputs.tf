
output "ec2-id" {

  // Percorre o resource e imprime o id da instância como saída.
  value = [for key, value in aws_instance.web : value.id]

}