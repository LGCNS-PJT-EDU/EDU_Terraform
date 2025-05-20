variable "db_name" {
  type        = string
  description = "DB 이름"
}

variable "db_username" {
  type        = string
  description = "DB 관리자 계정"
}

variable "db_password" {
  type        = string
  description = "DB 비밀번호"
  sensitive   = true
}