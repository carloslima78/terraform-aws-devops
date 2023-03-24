
terraform{
    required_version = ">=1.3.7"

}

provider "aws" {
    region = "us-east-1"
}

// Fila SQS
resource "aws_sqs_queue" "terraform-queue" {
  name = "terraform-queue"
}