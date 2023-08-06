resource "aws_s3_bucket_ownership_controls" "logs" {
  bucket = aws_s3_bucket.logs.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
