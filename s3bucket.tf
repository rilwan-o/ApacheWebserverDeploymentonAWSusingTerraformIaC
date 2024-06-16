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



resource "aws_s3_bucket" "web_config_bucket" {
  bucket = "groupc-web-config-bucket"
}

resource "aws_sns_topic" "web_notifications" {
  name = "web-notifications"
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

resource "aws_iam_policy" "s3_policy" {
  name        = "S3AccessPolicy"
  description = "Policy for S3 PUT/GET access"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "s3:PutObject",
        "s3:GetObject"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::your-bucket-name/*"
    }]
  })
}

resource "aws_iam_policy" "ssm_policy" {
  name        = "SSMAccessPolicy"
  description = "Policy for Session Manager access"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "ssm:StartSession",
        "ssm:SendCommand",
        "ssm:DescribeInstanceInformation",
        "ssm:DescribeSessions",
        "ssm:GetDeployablePatchSnapshotForInstance",
        "ssm:GetDocument",
        "ssm:ListInstanceAssociations",
        "ssm:ListAssociations",
        "ssm:ListDocuments",
        "ssm:ListTagsForResource",
        "ssm:PutInventory",
        "ssm:UpdateInstanceInformation"
      ]
      Effect   = "Allow"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
  role       = aws_iam_role.web_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_ssm_policy" {
  role       = aws_iam_role.web_role.name
  policy_arn = aws_iam_policy.ssm_policy.arn
}
