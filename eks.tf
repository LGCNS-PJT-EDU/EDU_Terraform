resource "aws_eks_cluster" "takeit" {
  name = "takeit-eks"
}

resource "aws_eks_node_group" "takeit" {
  ami_type      = "AL2023_x86_64_STANDARD"
  arn           = "arn:aws:eks:ap-northeast-2:754874159206:nodegroup/takeit-eks/takeit/16cb662f-a9c9-f3ca-9dee-491a9b5c69aa"
  capacity_type = "ON_DEMAND"
  cluster_name  = "takeit-eks"
  disk_size     = 50
  id            = "takeit-eks:takeit"
  instance_types = [
    "t3.medium",
  ]
  labels = {
    "role" = "spring"
  }
  node_group_name        = "takeit"
  node_group_name_prefix = null
  node_role_arn          = "arn:aws:iam::754874159206:role/ekspolicy"
  release_version        = "1.32.3-20250505"
  resources = [
    {
      autoscaling_groups = [
        {
          name = "eks-takeit-16cb662f-a9c9-f3ca-9dee-491a9b5c69aa"
        },
      ]
      remote_access_security_group_id = null
    },
  ]
  status = "ACTIVE"
  subnet_ids = [
    "subnet-0542b0f2acfcfcdb4",
    "subnet-082113b8176133630",
    "subnet-0a5d6f7c24eb12be0",
    "subnet-0e0cf4888542902cc",
  ]
  tags = {}
  tags_all = {}
  version = "1.32"

  node_repair_config {
    enabled = false
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable            = 1
    max_unavailable_percentage = 0
  }
}

resource "aws_eks_node_group" "fastapi" {
  ami_type               = "AL2023_x86_64_STANDARD"
  arn                    = "arn:aws:eks:ap-northeast-2:754874159206:nodegroup/takeit-eks/fastapi/fecb66ee-af4f-7223-ac1c-63a2fe6a6ef4"
  capacity_type          = "ON_DEMAND"
  cluster_name           = "takeit-eks"
  disk_size              = 50
  id                     = "takeit-eks:fastapi"
  instance_types         = [
    "t3.medium",
  ]
  labels                 = {
    "role" = "fastapi"
  }
  node_group_name        = "fastapi"
  node_group_name_prefix = null
  node_role_arn          = "arn:aws:iam::754874159206:role/ekspolicy"
  release_version        = "1.32.3-20250505"
  resources              = [
    {
      autoscaling_groups              = [
        {
          name = "eks-fastapi-fecb66ee-af4f-7223-ac1c-63a2fe6a6ef4"
        },
      ]
      remote_access_security_group_id = null
    },
  ]
  status                 = "ACTIVE"
  subnet_ids             = [
    "subnet-0542b0f2acfcfcdb4",
    "subnet-082113b8176133630",
    "subnet-0a5d6f7c24eb12be0",
    "subnet-0e0cf4888542902cc",
  ]
  tags                   = {}
  tags_all               = {}
  version                = "1.32"

  node_repair_config {
    enabled = false
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable            = 1
    max_unavailable_percentage = 0
  }
}
