# 해당 VPC에 포함된 subnet ID 목록 가져오기
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


# 1. EKS 클러스터 생성 (기본 VPC 사용)
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "takeit-eks"
  cluster_version = "1.27"
  vpc_id          = data.aws_vpc.default.id
  subnet_ids      = data.aws_subnets.default.ids


  eks_managed_node_groups = {
    default = {
      instance_types   = ["t3.medium"]
      desired_capacity = 1 // 처음에 몇 개의 인스턴스를 생성할지
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

# 2. Argo CD Helm 설치
resource "helm_release" "argo_cd" {
  depends_on = [module.eks]

  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    file("argo-values.yaml")
  ]
}

#3. Argo CD Application (spring app)
resource "kubernetes_manifest" "spring_app" {
  depends_on = [module.eks]

  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "spring-app" // ArgoCD 내부의 Application의 이름
      namespace = "argocd" // Application 리소스를 생성할 k8s 네임스페이스 (ArgoCD가 설치된 곳)
    }
    spec = {
      project = "default" // ArgoCD 프로젝트 이름
      source = { // Git 저장소의 위치와 어떤 디렉토리 아래 있는 K8s 매니페스트를 사용할지 지정
        repoURL        = "https://github.com/LGCNS-PJT-EDU/EDU_BE.git"
        targetRevision = "main"
        path           = "k8s"
      }
      destination = { // 배포 대상 클러스터와 네임스페이스
        server    = "https://kubernetes.default.svc" // 현재 EKS 클러스터 자체를 의미
        namespace = "spring" // spring 네임스페이스 안에 리소스를 생성하게 됩니다.
      }
      syncPolicy = {
        automated = { // Git 상태와 K8s 상태가 다르면 자동으로 동기화 수행
          prune     = true // Git에서 삭제된 리소스는 클러스터에서도 자동 삭제
          selfHeal  = true // 리소스가 수동으로 변경되면 Git상태로 다시 덮어씌움
        }
      }
    }
  }
}

# 4. IAM Role for EKS to pull ECR (선택적)
# 필요한 경우 추가 IAM Role 및 IRSA 설정 가능
resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = module.eks.eks_managed_node_groups["default"].iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

