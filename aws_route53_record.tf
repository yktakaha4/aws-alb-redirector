resource "aws_route53_record" "source" {
  name    = var.redirector_source_domain_name
  type    = "A"
  zone_id = aws_route53_zone.source.zone_id

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "source_subdomain" {
  name    = local.redirector_source_subdomain_name
  type    = "A"
  zone_id = aws_route53_zone.source.zone_id

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "fixed" {
  name    = local.redirector_fixed_domain_name
  type    = "A"
  zone_id = aws_route53_zone.source.zone_id

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "source_acm_certificate" {
  for_each = {
    for dvo in aws_acm_certificate.source.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 3600
  type            = each.value.type
  zone_id         = aws_route53_zone.source.zone_id
}

resource "aws_route53_record" "source_subdomain_acm_certificate" {
  for_each = {
    for dvo in aws_acm_certificate.source_subdomain.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 3600
  type            = each.value.type
  zone_id         = aws_route53_zone.source.zone_id
}
