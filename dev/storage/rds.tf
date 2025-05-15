#  MySQL RDS 인스턴스 생성
resource "aws_db_instance" "default" {
  identifier         = "takeitdb"                 # RDS 인스턴스 ID
  allocated_storage  = 20                         # 20GB 스토리지
  engine             = "mysql"                    # MySQL 사용
  instance_class     = "db.t3.small"              # 작은 사이즈의 DB 인스턴스 (테스트/개발용)
  db_name            = "takeitdb"                 # 내부에서 사용할 데이터베이스 이름
  username           = "takeit"                   # 기본 접속 유저명
  password           = "takeit1029!"              # 기본 비밀번호 (민감정보 → 나중에 변수화 추천)
  skip_final_snapshot = true                      # 삭제 시 최종 스냅샷 저장 안 함 (주의)
  publicly_accessible = true                      # 외부 접속 허용 (테스트용 OK, 실무는 X)

  vpc_security_group_ids = [data.aws_security_group.default.id]  # 연결할 보안 그룹 ID
}
