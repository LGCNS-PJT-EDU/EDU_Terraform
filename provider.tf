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

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_name
# }

# provider "kubernetes" {
#   host                   = try(module.eks.cluster_endpoint, "")
#   cluster_ca_certificate = try(base64decode(module.eks.cluster_certificate_authority_data), "")
#   token                  = try(data.aws_eks_cluster_auth.cluster.token, "")
# }

# provider "kubernetes" {
#   host                   = module.eks.cluster_endpoint
#   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }
#
#     provider "helm" {
#   kubernetes {
#     host                   = try(module.eks.cluster_endpoint, "")
#     cluster_ca_certificate = try(base64decode(module.eks.cluster_certificate_authority_data), "")
#     token                  = try(data.aws_eks_cluster_auth.cluster.token, "")
#   }
# }
#

