# variables.tf

variable "iam_user_name" {
  description = "Name of the IAM user to create"
  type        = string
}

variable "group_name" {
  description = "Name of the IAM group to create"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}
