output "athena_s3_bucket_id" {
  description = ""
  value       = module.example.s3_bucket_id
}

output "athena_kms_key_arn" {
  description = ""
  value       = module.example.kms_key_arn
}

output "athena_workgroup_arn" {
  description = ""
  value       = module.example.workgroup_arn
}

output "athena_database_id" {
  description = ""
  value       = module.example.database_id
}
