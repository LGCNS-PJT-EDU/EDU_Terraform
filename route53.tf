resource "aws_route53_zone" "primary" {
  name = "takeit.academy"
}

resource "aws_route53_record" "cloudfront_alias" {
  name    = "takeit.academy"
  type    = "A"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.frontend.domain_name
    zone_id                = aws_cloudfront_distribution.frontend.hosted_zone_id
  }
}
