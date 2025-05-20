# 탄력적 IP 생성
resource "aws_eip" "db_eip" {
  tags = {
    Name = "db-eip"
  }
}

# 탄력적 IP를 EC2 인스턴스에 연결
resource "aws_eip_association" "db_eip_assoc" {
  instance_id   = aws_instance.db.id # 지정할 인스턴스
  allocation_id = aws_eip.db_eip.id
}

resource "aws_eip" "gateway_eip" {

}
