resource "aws_lb_listener_rule" "main_subdomain" {
  for_each = toset([
    aws_lb_listener.main_https.arn,
    aws_lb_listener.main_http.arn,
  ])

  listener_arn = each.value
  priority     = 10

  condition {
    host_header {
      values = [local.redirector_source_subdomain_name]
    }
  }

  action {
    type = "redirect"

    redirect {
      port        = "443"
      host        = var.redirector_subdomain_destination_domain_name
      protocol    = "HTTPS"
      status_code = "HTTP_301"

      path  = "/"
      query = ""
    }
  }
}

resource "aws_lb_listener_rule" "main_fixed_style" {
  for_each = toset([
    aws_lb_listener.main_https.arn,
    aws_lb_listener.main_http.arn,
  ])

  listener_arn = each.value
  priority     = 20

  condition {
    host_header {
      values = [local.redirector_fixed_domain_name]
    }
  }

  condition {
    path_pattern {
      values = ["/fixed.css"]
    }
  }

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/css"
      status_code  = "200"
      message_body = templatefile("${path.module}/templates/fixed.css", {})
    }
  }
}

resource "aws_lb_listener_rule" "main_fixed" {
  for_each = toset([
    aws_lb_listener.main_https.arn,
    aws_lb_listener.main_http.arn,
  ])

  listener_arn = each.value
  priority     = 25

  condition {
    host_header {
      values = [local.redirector_fixed_domain_name]
    }
  }

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      status_code  = "410"
      message_body = templatefile(
        "${path.module}/templates/fixed.html",
        {
          domain_name = local.redirector_fixed_domain_name
        }
      )
    }
  }
}
