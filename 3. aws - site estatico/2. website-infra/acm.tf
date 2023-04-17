resource "aws_acm_certificate" "this" {

  # Só criará o certificado se existir um domínio registrado.
  count = local.has_domain ? 1 : 0

  # A região deve ser a do certificado
  provider = aws.us-east-1

  domain_name               = local.domain
  validation_method         = "DNS"
  subject_alternative_names = ["*.${local.domain}"]
}

resource "aws_acm_certificate_validation" "this" {

  # Só validará o certificado se existir um domínio registrado.
  count = local.has_domain ? 1 : 0

  # A região deve ser a do certificado
  provider = aws.us-east-1

  certificate_arn = aws_acm_certificate.this[0].arn

  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
