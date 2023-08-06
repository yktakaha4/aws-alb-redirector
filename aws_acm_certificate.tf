resource "aws_acm_certificate" "source" {
  domain_name       = var.redirector_source_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "source_subdomain" {
  domain_name               = local.redirector_source_subdomain_name
  validation_method         = "DNS"
  subject_alternative_names = ["*.${local.redirector_source_subdomain_name}"]

  lifecycle {
    create_before_destroy = true
  }
}
