variable "create_s3_bucket" {
  description = "Enable the creation of an S3 bucket to use Athena query results"
  type        = bool
  default     = true
}

variable "athena_s3_bucket_id" {
  description = "Use an existing S3 bucket for Athena query results if `create_s3_bucket` is `false`."
  type        = string
  default     = null
}

variable "create_kms_key" {
  description = "Enable the creation of a KMS key used by Athena workgroup."
  type        = bool
  default     = true
}

variable "athena_kms_key" {
  description = "Use an existing KMS key for Athena if `create_kms_key` is `false`."
  type        = string
  default     = null
}

variable "athena_kms_key_deletion_window" {
  description = "KMS key deletion window (in days)."
  type        = number
  default     = 7
}

variable "workgroup_description" {
  description = "A description the of Athena workgroup."
  type        = string
  default     = ""
}

variable "bytes_scanned_cutoff_per_query" {
  description = "Integer for the upper data usage limit (cutoff) for the amount of bytes a single query in a workgroup is allowed to scan. Must be at least 10485760."
  type        = number
  default     = null
}

variable "enforce_workgroup_configuration" {
  description = "Boolean whether the settings for the workgroup override client-side settings."
  type        = bool
  default     = true
}

variable "publish_cloudwatch_metrics_enabled" {
  description = "Boolean whether Amazon CloudWatch metrics are enabled for the workgroup."
  type        = bool
  default     = true
}

variable "encryption_option" {
  description = "Indicates whether Amazon S3 server-side encryption with Amazon S3-managed keys (SSE_S3), server-side encryption with KMS-managed keys (SSE_KMS), or client-side encryption with KMS-managed keys (CSE_KMS) is used."
  type        = string
  default     = "SSE_KMS"
}

variable "s3_output_path" {
  description = "The S3 bucket path used to store query results."
  type        = string
  default     = ""
}

variable "workgroup_state" {
  description = "State of the workgroup. Valid values are `DISABLED` or `ENABLED`."
  type        = string
  default     = "ENABLED"
}

variable "databases" {
  description = "List of Athena databases to provision within this workgroup."
  type        = list(string)
}
