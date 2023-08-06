resource "aws_lb_listener" "main_http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      host        = var.redirector_default_destination_domain_name
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "main_https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  certificate_arn = aws_acm_certificate.source.arn

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      host        = var.redirector_default_destination_domain_name
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
