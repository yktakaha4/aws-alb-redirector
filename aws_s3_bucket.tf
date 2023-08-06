resource "aws_s3_bucket" "logs" {
  bucket = "${var.service}-${var.env}-logs"

  force_destroy = true
}
