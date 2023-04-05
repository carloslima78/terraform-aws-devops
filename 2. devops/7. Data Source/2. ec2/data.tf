
// Data do tipo ami (Imagem de EC2 pronta)
data "aws_ami" "ubuntu" {

  owners      = ["amazon"]
  most_recent = true
  name_regex  = "ubuntu"
}