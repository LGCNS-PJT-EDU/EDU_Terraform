resource "aws_acm_certificate" "cert" {
  provider          = aws
  domain_name       = "takeit.academy"
  validation_method = "DNS" // 검증용 DNS 레코드를 Route53에 등록

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "cert_validation" {
  for_each = { // domain_validation_options에서 레코드들을 하나씩 뽑아서 Route53에 등록
    for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider                = aws.use1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}