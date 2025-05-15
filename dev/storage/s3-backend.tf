resource "aws_s3_bucket" "tf_backend" {
  bucket = "takeit-terraform-state"

  tags = {
    Name = "Terraform State Bucket"
  }
}