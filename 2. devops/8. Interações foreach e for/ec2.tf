
// Data Source para recuperar uma imagem dinâmicamente para EC2.
data "aws_ami" "ubuntu" {

    owners = ["amazon"]
    most_recent = true
    name_regex = "ubuntu"

    // Fltro para recuperar somente imagens compatíveis com x86_64.
    filter {

        name = "architecture"
        values = ["x86_64"]
    }
}

// Recurso para criar duas instâncias EC2 conforme interação foreach.
resource "aws_instance" "web" {

  for_each = {
    
    "web" = {

        name = "web server"
        type = "t3.medium"
    }

    "ci-cd" = {

        name = "ci/cd server"
        type = "t3.micro"
    }
  }

  ami = data.aws_ami.ubuntu.id

  instance_type = lookup(each.value, "type", null)

  tags = {
    
    "Project" = "Testanto Interações Foreach"
    
    "Name" = "${each.key}: ${lookup(each.value, "name", null)}"
  }
}