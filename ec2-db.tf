# 최신 Ubuntu 22.04 LTS (Jammy) AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Ubuntu 공식 계정 (Canonical)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 기본 VPC 및 서브넷 정보
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

# EC2 인스턴스 생성 (DB 용도)
resource "aws_instance" "db" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_security_group.default.id]

  key_name = "takeit"

  root_block_device {
    volume_size = 50              # 50GB 스토리지
    volume_type = "gp3"           # 범용 SSD
    delete_on_termination = true
  }

  tags = {
    Name        = "db-ubuntu"
    Environment = "dev"
    Role        = "database"
  }
}
