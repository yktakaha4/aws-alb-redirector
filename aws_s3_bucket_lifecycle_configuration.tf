resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  bucket = aws_s3_bucket.logs.bucket

  rule {
    id     = "expiration"
    status = "Enabled"

    expiration {
      days = 365 * 7
    }
  }
}
