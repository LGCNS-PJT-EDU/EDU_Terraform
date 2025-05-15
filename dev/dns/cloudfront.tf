# CloudFront 배포 리소스 정의
resource "aws_cloudfront_distribution" "frontend" {
  enabled             = true                      # CloudFront 배포 활성화
  is_ipv6_enabled     = true                      # IPv6 지원 활성화
  default_root_object = "index.html"              # 기본 진입 파일 (S3 정적 웹 호스팅 기준)

  aliases = ["takeit.academy"]                    # 연결할 사용자 도메인

  origin {
    domain_name = aws_s3_bucket.takeit_bucket.website_endpoint  # 정적 파일이 위치한 S3 웹사이트 엔드포인트
    origin_id   = "takeitS3Origin"                # 원본 ID (아래 캐시 정책과 연결됨)

    custom_origin_config {
      http_port              = 80                 # HTTP 포트
      https_port             = 443                # HTTPS 포트
      origin_protocol_policy = "http-only"        # CloudFront → S3 전송 시 HTTP만 허용
      origin_ssl_protocols   = ["TLSv1.2"]        # CloudFront가 원본과 통신할 때 사용할 SSL 프로토콜
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]      # 허용할 HTTP 메서드
    cached_methods         = ["GET", "HEAD"]      # 캐시할 HTTP 메서드
    target_origin_id       = "takeitS3Origin"     # 연결할 origin 설정 ID
    viewer_protocol_policy = "redirect-to-https"  # 사용자가 HTTP로 접속해도 HTTPS로 자동 리디렉션

    forwarded_values {
      query_string = false                        # 쿼리 스트링은 캐싱 키로 사용하지 않음
      cookies {
        forward = "none"                          # 쿠키는 전달하거나 캐시하지 않음
      }
    }
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.cert.arn  # 사용할 ACM 인증서 (HTTPS)
    ssl_support_method       = "sni-only"                     # Server Name Indication 방식 사용
    minimum_protocol_version = "TLSv1.2_2021"                 # 최소 TLS 버전 제한
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"                  # 국가별 제한 없음
    }
  }

  tags = {
    Name = "frontend_cdn"                        # 리소스 태그 (관리 편의)
  }

  # 인증서 검증 리소스가 먼저 생성된 후 실행되도록 의존성 설정
  depends_on = [aws_acm_certificate_validation.cert_validation]
}
