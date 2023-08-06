resource "aws_route53_zone" "source" {
  name = var.redirector_source_domain_name
}
