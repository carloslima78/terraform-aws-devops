
# Locals contendo os dados da instância EC2 que vamos acessar
locals {

  instance = {

    id  = data.terraform_remote_state.server.outputs.id
    ami = data.terraform_remote_state.server.outputs.ami
    arn = data.terraform_remote_state.server.outputs.arn
  }

}