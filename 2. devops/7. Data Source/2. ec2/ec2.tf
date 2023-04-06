
resource "aws_instance" "web" {

  ami = data.aws_ami.ubuntu.id
  instance_type = var.type
}