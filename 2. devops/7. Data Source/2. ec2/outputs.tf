
/* Id da instância EC2 gerada.

  Para imprimir os outputs abaixo no arquivo "outputs.json" no módulo do S3, executar o comando abaixo
  dentro desse módulo:

    terraform output -json > ../s3/outputs.json
*/
output "id" {

  value = aws_instance.web.id
}

// AMI da instância EC2 gerada
output "ami" {

  value = aws_instance.web.ami
}

// ARN da instância EC2 gerada
output "arn" {

  value = aws_instance.web.arn
}