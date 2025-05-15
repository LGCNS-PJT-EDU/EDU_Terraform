/*
# 최신 Ubuntu 22.04 LTS AMI 검색 (Canonical 공식 제공)
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical (Ubuntu 공식 계정)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 기본 VPC 조회
data "aws_vpc" "default" {
  default = true
}

# 기본 보안 그룹 조회
data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# EC2 인스턴스 생성 (MongoDB, Redis, ChromaDB 등 설치 목적)
resource "aws_instance" "db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"                        # 비교적 가벼운 DB 운영용 사양
  vpc_security_group_ids = [data.aws_security_group.default.id]
  key_name               = "takeit"                          # EC2 접속용 키페어 이름 (사전에 존재해야 함)

  root_block_device {
    volume_size           = 50                               # 50GB 디스크
    volume_type           = "gp3"                            # 일반 SSD
    delete_on_termination = true                             # EC2 종료 시 디스크도 삭제
  }

  tags = {
    Name        = "db-ubuntu"
    Environment = "dev"
    Role        = "database"
  }
}
 */
