resource "aws_lb" "main" {
  name               = "${var.service}-${var.env}-main"
  load_balancer_type = "application"

  internal = false

  security_groups = [
    aws_security_group.main.id,
  ]

  subnets = data.aws_subnets.default.ids

  tags = {
    "Name" = "${var.service}-${var.env}-main"
  }
}
