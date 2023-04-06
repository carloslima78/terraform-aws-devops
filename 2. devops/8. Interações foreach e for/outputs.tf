
// output para imprimir as extenções na coleção em locals.tf
output "extensions" {
     
     value = local.file_extensions
}

// output para imprimir as ARNs das instâncias criadas
output "instance-arns" {
     
     value = [for k, v in aws_instance.web : v.arn]
}

