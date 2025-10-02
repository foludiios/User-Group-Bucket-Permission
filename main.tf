provider "aws" {
  region = "us-east-1" 
}

data "aws_caller_identity" "current" {}

resource "aws_iam_user" "user" {
  name = var.iam_user_name
}

resource "aws_iam_group" "group" {
  name = var.group_name
}

resource "aws_iam_policy" "s3_full_access" {
  name        = "${var.group_name}_s3_full_access"
  description = "Full access to the ${var.s3_bucket_name} S3 bucket for ${var.group_name}"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "s3:*"
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "attach_policy" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}

resource "aws_iam_user_group_membership" "membership" {
  user   = aws_iam_user.user.name
  groups = [aws_iam_group.group.name]
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowAccountListBucket",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "s3:ListBucket",
        Resource = "arn:aws:s3:::${var.s3_bucket_name}"
      }
    ]
  })
}
