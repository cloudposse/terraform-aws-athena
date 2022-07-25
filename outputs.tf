output "s3_bucket_id" {
  description = "ID of S3 bucket used by Athena."
  value       = aws_s3_bucket.default[0].id
}

output "kms_key_arn" {
  description = "ARN of KMS key used by Athena."
  value       = aws_kms_key.default[0].arn
}

output "workgroup_arn" {
  description = "ARN of newly created Athena workgroup."
  value       = aws_athena_workgroup.default[0].arn
}

output "database_id" {
  description = "ID of newly created Athena database."
  value       = aws_athena_database.default[0].id
}
