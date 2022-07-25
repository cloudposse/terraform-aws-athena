output "s3_bucket_id" {
  description = ""
  value       = aws_s3_bucket.default[0].id
}

output "kms_key_arn" {
  description = ""
  value       = aws_kms_key.default[0].arn
}

output "workgroup_arn" {
  description = ""
  value       = aws_athena_workgroup.default[0].arn
}

output "database_id" {
  description = ""
  value       = aws_athena_database.default[0].id
}
