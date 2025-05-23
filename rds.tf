resource "aws_db_instance" "default" {
  identifier = "takeitdb"
  allocated_storage = 20
  engine = "mysql"
  instance_class = "db.t3.small"
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
  skip_final_snapshot = true // DB 삭제할 때 필요
  publicly_accessible = true // 외부 접속 허용

  vpc_security_group_ids = [data.aws_security_group.default.id]
}