locals {
  enabled = module.this.enabled

  s3_bucket_id = var.create_s3_bucket ? try(aws_s3_bucket.default[0].id, null) : var.athena_s3_bucket_id
}

resource "aws_s3_bucket" "default" {
  count = local.enabled && var.create_s3_bucket ? 1 : 0

  bucket = module.this.id
  tags   = module.this.tags

  force_destroy = true
}

resource "aws_kms_key" "default" {
  count = local.enabled && var.create_kms_key ? 1 : 0

  deletion_window_in_days = var.athena_kms_key_deletion_window
  description             = "Athena KMS Key"
}

resource "aws_athena_workgroup" "default" {
  count = local.enabled ? 1 : 0

  name = module.this.id

  configuration {
    bytes_scanned_cutoff_per_query     = var.bytes_scanned_cutoff_per_query
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics_enabled

    result_configuration {
      encryption_configuration {
        encryption_option = var.encryption_option
        kms_key_arn       = aws_kms_key.default[0].arn
      }
      output_location = format("s3://%s/%s", local.s3_bucket_id, var.s3_output_path)
    }
  }

  tags = module.this.tags
}

resource "aws_athena_database" "default" {
  for_each = local.enabled ? toset(var.databases) : []

  name   = each.value
  bucket = local.s3_bucket_id
}
