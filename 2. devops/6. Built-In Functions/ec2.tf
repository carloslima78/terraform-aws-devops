resource "aws_instance" "server" {

  /* O "count" é uma propriedade do Terraform para controle da quantidade de recursos de um 
      determinado tipo. */
  count = local.instance_number < 0 ? 0 : local.instance_number

  ami = var.ec2-instance-ami

  # "lookup busca o valor de uma variável de acordo com a chave"
  instance_type = lookup(var.ec2-instance-type, var.environment)

  tags = merge(

    local.commom_tags, {

      Project = "Estuto AWS com Terraform"

      # "format é semelhante ao print do Java"
      Environment = format("%s", var.environment)
      Name        = format("Instance %d", count.index + 1)
    }
  )
}