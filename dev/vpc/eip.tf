/*
# 탄력적 IP (Elastic IP, EIP)를 생성하는 리소스
resource "aws_eip" "db_eip" {
  tags = {
    Name = "db-eip"  # 리소스 태그 (식별 목적)
  }
}

# 생성한 EIP를 EC2 인스턴스에 연결하는 리소스
resource "aws_eip_association" "db_eip_assoc" {
  instance_id   = aws_instance.db.id        # 연결 대상 EC2 인스턴스 ID
  allocation_id = aws_eip.db_eip.id         # 위에서 만든 EIP의 ID
}
 */
