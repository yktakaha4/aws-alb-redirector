resource "aws_lb_listener_certificate" "source_subdomain" {
  listener_arn    = aws_lb_listener.main_https.arn
  certificate_arn = aws_acm_certificate.source_subdomain.arn
}
