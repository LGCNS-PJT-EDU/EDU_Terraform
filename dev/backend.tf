terraform {
  backend "s3" {
    # S3를 상태 파일(.tfstate)의 저장소로 사용합니다
    #
    # Terraform은 모든 리소스를 추적하기 위해 상태 파일을 유지하는데,
    # 기본적으로 로컬에 저장되므로 협업하거나 CI/CD에서 실행하면 충돌 위험이 생깁니다.
    #
    # S3를 백엔드로 설정하면:
    #   - 여러 명이 같은 상태 파일을 참조하여 **협업 가능**
    #   - GitHub Actions, Jenkins 등에서 **CI/CD로 배포 가능**
    #   - S3는 저렴하고 안전한 백업 공간 제공
    #
    # (DynamoDB를 추가하면 락 기능도 추가되지만, 단일 사용자라면 생략 가능)

    bucket = "takeit-terraform-state"     # Terraform 상태 파일을 저장할 S3 버킷 이름 (사전 생성 필요)
    key    = "dev/terraform.tfstate"      # S3 내 상태 파일 경로 (폴더/파일처럼 생각)
    region = "ap-northeast-2"             # S3 버킷이 존재하는 리전 (서울)
    encrypt = true                        # 상태 파일 서버 측 암호화 (기본 보안 설정)
  }
}
