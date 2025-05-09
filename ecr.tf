resource "aws_ecr_repository" "fastapi" {
  name = "takeit/fastapi"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = "ecr-fastapi"
    Environment = "dev"
    Project     = "takeit"
  }
}

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
