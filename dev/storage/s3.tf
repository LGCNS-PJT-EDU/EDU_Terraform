# S3 버킷 생성 (정적 웹사이트 호스팅용)
resource "aws_s3_bucket" "takeit_bucket" {
  bucket        = "takeit-bucket"   # 고유한 버킷 이름 (전 세계에서 유일해야 함)
  force_destroy = true              # terraform destroy 시 객체가 있어도 강제 삭제 (실무에선 false 권장)
}

# 웹사이트 호스팅 구성 (index.html 기반 SPA)
resource "aws_s3_bucket_website_configuration" "takeit_website" {
  bucket = aws_s3_bucket.takeit_bucket.id

  index_document {
    suffix = "index.html"           # SPA 루트
  }

  error_document {
    key = "index.html"              # SPA 라우팅을 위한 fallback
  }
}

# 퍼블릭 접근 허용을 위한 Public Access Block 설정 해제
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.takeit_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# 모든 사용자에게 읽기 권한 부여 (정적 웹사이트 공개용 정책)
resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket     = aws_s3_bucket.takeit_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.public_access]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicRead",
        Effect    = "Allow",
        Principal = "*",                       # 누구든 접근 가능
        Action    = ["s3:GetObject"],          # 객체 읽기 권한만 허용
        Resource  = ["${aws_s3_bucket.takeit_bucket.arn}/*"]
      }
    ]
  })
}
