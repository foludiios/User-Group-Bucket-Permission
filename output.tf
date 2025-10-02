output "iam_user_name" {
  description = "The name of the created IAM user"
  value       = aws_iam_user.user.name
}

output "iam_group_name" {
  description = "The name of the IAM group"
  value       = aws_iam_group.group.name
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.bucket.arn
}

output "account_id" {
  description = "The AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}
