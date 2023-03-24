terraform{
    required_version = ">=1.3.7"

}

provider "aws" {
    region = "us-east-1"
}

// Bucket S3
resource "aws_s3_bucket" "terraform-buckets3-teste" {
    bucket = "meu-bucket"
    acl = "private"
}