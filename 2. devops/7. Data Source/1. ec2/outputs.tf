
// Id da instância EC2 gerada
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