resource "aws_s3_bucket" "takeit-bucket" {
  bucket = "takeit-bucket"
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.takeit-bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.takeit-bucket.id
  depends_on = [
    aws_s3_bucket_public_access_block.public_access
  ]
  policy = <<POLICY
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid":"PublicRead",
      "Effect":"Allow",
      "Principal":"*",
      "Action":["s3:GetObject"],
      "Resource": ["arn:aws:s3:::${aws_s3_bucket.takeit-bucket.id}/*"]
    }
  ]
}
POLICY
}