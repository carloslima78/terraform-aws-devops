
resource "aws_instance" "web" {

  // Atribui a imagem do ubuntu para a instância
  ami           = "ami-0263e4deb427da90e"
  // ami = data.aws_ami.ubuntu.id
  instance_type = var.type
}