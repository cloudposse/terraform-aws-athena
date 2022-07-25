output "athena_s3_bucket_id" {
  description = "ID of S3 bucket used by Athena."
  value       = module.example.s3_bucket_id
}

output "athena_kms_key_arn" {
  description = "ARN of KMS key used by Athena."
  value       = module.example.kms_key_arn
}

output "athena_workgroup_arn" {
  description = "ARN of newly created Athena workgroup."
  value       = module.example.workgroup_arn
}

output "athena_database_id" {
  description = "ID of newly created Athena database."
  value       = module.example.database_id
}
