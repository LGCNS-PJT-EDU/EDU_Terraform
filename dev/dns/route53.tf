# 도메인 호스팅 존 생성 (Route53에 도메인을 등록/관리할 공간 만들기)
resource "aws_route53_zone" "primary" {
  name = "takeit.academy"         # 소유한 도메인 이름
}

# CloudFront 도메인에 A 레코드 연결 (Alias 방식)
resource "aws_route53_record" "cloudfront_alias" {
  name    = "takeit.academy"      # DNS 레코드 이름 (도메인 루트)
  type    = "A"                   # A 레코드 (IPv4)

  zone_id = aws_route53_zone.primary.zone_id  # 연결할 호스팅 존 ID

  alias {
    evaluate_target_health = false             # 헬스체크 미사용
    name                   = aws_cloudfront_distribution.frontend.domain_name  # CloudFront 도메인 연결
    zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
  }
}
