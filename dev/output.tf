# Route53 호스팅 존의 네임서버 출력
output "name_servers" {
  value = aws_route53_zone.primary.name_servers   # 도메인을 구입한 곳에 등록할 NS 레코드
}

# EKS 클러스터 관련 정보 출력
# output "cluster_endpoint" {
#   value = module.eks.cluster_endpoint           # 클러스터 API 서버 엔드포인트
# }

# output "cluster_cert" {
#   value = module.eks.cluster_certificate_authority_data  # 인증서 (kubectl 연결 시 필요)
# }

# output "cluster_name" {
#   value = module.eks.cluster_name               # 클러스터 이름
# }
