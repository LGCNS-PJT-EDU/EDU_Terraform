# FastAPI 백엔드용 ECR 저장소 생성
resource "aws_ecr_repository" "fastapi" {
  name = "takeit/fastapi"                       # ECR 저장소 이름 (URI로 쓰임: {account_id}.dkr.ecr.../takeit/fastapi)

  image_scanning_configuration {
    scan_on_push = true                         # 이미지를 푸시할 때 보안 취약점 스캔 자동 수행
  }

  encryption_configuration {
    encryption_type = "AES256"                  # 저장된 이미지 암호화 (기본 방식)
  }

  tags = {
    Name        = "ecr-fastapi"                 # 리소스 태그 - 이름
    Environment = "dev"                         # 환경 구분
    Project     = "takeit"                      # 프로젝트 식별용
  }
}

# Spring 백엔드용 ECR 저장소 생성
resource "aws_ecr_repository" "spring" {
  name = "takeit/spring"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "ecr-spring"
    Environment = "dev"
    Project     = "takeit"
  }
}
