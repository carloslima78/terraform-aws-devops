
resource "aws_instance" "web" {

  // Atribui a "ami" que será recuperada no arquivo "data.tf"
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.type
}