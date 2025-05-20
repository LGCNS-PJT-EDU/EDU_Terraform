output "rds_endpoint" {
  description = "RDS 접속용 호스트 이름"
  value       = aws_db_instance.default.endpoint
}

output "rds_address" {
  description = "RDS 엔드포인트의 DNS 주소 (호스트네임만)"
  value       = aws_db_instance.default.address
}

output "rds_port" {
  description = "RDS 포트"
  value       = aws_db_instance.default.port
}

output "rds_username" {
  description = "RDS 사용자명"
  value       = var.db_username
  sensitive   = true
}