
resource "random_string" "bucket_name" {
  lower   = true
  upper   = false
  length  = 16
  special = false
}

resource "aws_s3_bucket" "simple_bucket" {
  # Bucket Naming Rules
  #https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
  bucket = random_string.bucket_name.result
  
  tags = {
    UserUuid = var.user_uuid
  }
}

