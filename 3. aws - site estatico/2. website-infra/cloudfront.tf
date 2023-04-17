
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {

  comment = local.domain
}

resource "aws_cloudfront_distribution" "this" {
  
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Nosso CloudFront"
  default_root_object = "index.html"
  aliases             = local.has_domain ? [local.domain] : []

  logging_config {
    bucket          = module.logs.domain_name
    prefix          = "cnd/"
    include_cookies = true
  }

  # Bloco para gerenciamendo do comportamento do Cache 
  default_cache_behavior {

    allowed_methods = ["HEAD", "GET", "OPTIONS"]

    cached_methods = ["HEAD", "GET"]

    target_origin_id = local.regional_domain

    # Redireciona para HTTPS para sempre manter seguro
    viewer_protocol_policy = "redirect-to-https"

    # Valor mínimo de cache
    min_ttl = 0

    # Valor padrão de vida do cache (1 hora)
    default_ttl = 3600

    # Valor máximo de vida do cache (1 dia)
    max_ttl = 86400

    forwarded_values {

      query_string = false

      headers = ["Origin"]

      cookies {

        forward = "none"
      }
    }
  }

  origin {

    domain_name = local.regional_domain

    origin_id = local.regional_domain

    s3_origin_config {

      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  restrictions {

    geo_restriction {

      restriction_type = "none"
    }
  }

  viewer_certificate {

    cloudfront_default_certificate = true
  }

  tags = local.common_tags

}