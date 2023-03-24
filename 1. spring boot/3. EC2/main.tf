terraform{
    required_version = ">=1.3.7"

}

provider "aws" {
    region = "us-east-1"
}

// Instância EC2
resource "aws_instance" "terraform-ec2-teste"{
    ami = "ami-0263e4deb427da90e"
    instance_type = "t2.micro"
}