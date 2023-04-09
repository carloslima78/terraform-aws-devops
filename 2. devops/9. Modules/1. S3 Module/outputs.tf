
output "name" {

    value = aws_s3_bucket.this.id
}

output "arn" {

    value = aws_s3_bucket.this.arn
}

output "website" {

    value = aws_s3_bucket.this.website_endpoint
}

output "regional-domain-name" {

    value = aws_s3_bucket.this.bucket_regional_domain_name
}

output "domain-name" {

    value = aws_s3_bucket.this.bucket_domain_name
}

output "website-domain" {

    value = aws_s3_bucket.this.website_domain
}

output "hosted-zone-id" {

    value = aws_s3_bucket.this.hosted_zone_id
}