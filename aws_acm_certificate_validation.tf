resource "aws_acm_certificate_validation" "source" {
  certificate_arn         = aws_acm_certificate.source.arn
  validation_record_fqdns = [for record in aws_route53_record.source_acm_certificate : record.fqdn]
}

resource "aws_acm_certificate_validation" "source_subdomain" {
  certificate_arn         = aws_acm_certificate.source_subdomain.arn
  validation_record_fqdns = [for record in aws_route53_record.source_subdomain_acm_certificate : record.fqdn]
}
