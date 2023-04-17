
# Data para recuperar a zona
data "aws_route53_zone" "this" {

  count = local.has_domain ? 1 : 0

  name = "${local.domain}."
}

# Record para o domínio principal
resource "aws_route53_record" "website" {

  # Caso não exista um domínio registrado, criará um.
  count = local.has_domain ? 1 : 0

  name = local.domain

  type = "A"

  zone_id = data.aws_route53_zone.this[0].zone_id

  alias {

    evaluate_target_health = false

    name = aws_cloudfront_distribution.this.domain_name

    zone_id = aws_cloudfront_distribution.this.hosted_zone_id
  }
}

# Record para o www
resource "aws_route53_record" "www" {

  # Caso não exista um domínio registrado, criará um.
  count = local.has_domain ? 1 : 0

  name = "www.${local.domain}"

  type = "A"

  zone_id = data.aws_route53_zone.this[0].zone_id

  alias {

    evaluate_target_health = false

    name = module.redirect.website_domain

    zone_id = module.redirect.hosted_zone_id
  }
}

resource "aws_route53_record" "cert_validation" {

  provider = aws.us-east-1

  for_each = local.has_domain ? {
    for dvo in aws_acm_certificate.this[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.this[0].zone_id
}
