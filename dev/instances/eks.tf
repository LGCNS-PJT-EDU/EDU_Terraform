# ✅ Terraform 자체 버전과 provider 버전 요구사항 설정
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"                      # AWS provider 버전 5.x 사용
    }
  }

  required_version = ">= 1.5.0"              # Terraform CLI 버전 최소 조건
}

# AWS provider 기본 설정 - 서울 리전
provider "aws" {
  region = "ap-northeast-2"                 # 메인 인프라 (EKS, EC2, RDS 등은 서울 리전에 생성됨)
}

# AWS provider alias 설정 - us-east-1 리전 (ACM 인증서용)
provider "aws" {
  alias  = "use1"
  region = "us-east-1"                      # CloudFront 인증서(ACM)는 반드시 버지니아 리전에 있어야 함
}

# (선택) EKS 클러스터 인증 정보를 사용해서 Kubernetes provider 연결
# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_name
# }

# provider "kubernetes" {
#   host                   = try(module.eks.cluster_endpoint, "")
#   cluster_ca_certificate = try(base64decode(module.eks.cluster_certificate_authority_data), "")
#   token                  = try(data.aws_eks_cluster_auth.cluster.token, "")
# }

# (선택) Helm provider 설정 - EKS와 연결 필요
# provider "helm" {
#   kubernetes {
#     host                   = try(module.eks.cluster_endpoint, "")
#     cluster_ca_certificate = try(base64decode(module.eks.cluster_certificate_authority_data), "")
#     token                  = try(data.aws_eks_cluster_auth.cluster.token, "")
#   }
# }
