// aws 연결할때 필요한 코드
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "ap-northeast-2"
}

provider "aws" {
  alias = "use1"
  region = "us-east-1" # CloudFront 인증서 전용 리전
}
