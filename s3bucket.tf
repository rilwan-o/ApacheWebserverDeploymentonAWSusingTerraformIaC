resource "aws_s3_bucket" "terraform_state" {
  bucket = "groupc-terraform-state-bucket"
  
}


resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}




resource "aws_iam_role" "web_role" {
  name = "web-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}


resource "aws_s3_bucket" "web_config_bucket" {
  bucket = "groupc-web-config-bucket"
}

resource "aws_sns_topic" "web_notifications" {
  name = "web-notifications"
}

resource "aws_iam_role" "web_iam_role" {
  name = "web-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}