locals {
  enabled = module.this.enabled

  s3_bucket_id = var.create_s3_bucket ? try(aws_s3_bucket.default[0].id, null) : var.athena_s3_bucket_id
  kms_key_arn  = var.create_kms_key ? try(aws_kms_key.default[0].arn, null) : var.athena_kms_key
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
  description             = "Athena KMS Key for ${module.this.id}"
  tags                    = module.this.tags
}

resource "aws_athena_workgroup" "default" {
  count = local.enabled ? 1 : 0

  name = module.this.id

  configuration {
    bytes_scanned_cutoff_per_query     = var.bytes_scanned_cutoff_per_query
    enforce_workgroup_configuration    = var.enforce_workgroup_configuration
    publish_cloudwatch_metrics_enabled = var.publish_cloudwatch_metrics_enabled
    requester_pays_enabled             = var.requester_pays_enabled

    result_configuration {
      encryption_configuration {
        encryption_option = var.workgroup_encryption_option
        kms_key_arn       = local.kms_key_arn
      }
      output_location = format("s3://%s/%s", local.s3_bucket_id, var.s3_output_path)
    }
  }

  force_destroy = var.workgroup_force_destroy

  tags = module.this.tags
}

resource "aws_athena_database" "default" {
  for_each = local.enabled ? var.databases : {}

  name       = each.key
  bucket     = local.s3_bucket_id
  comment    = try(each.value.comment, null)
  properties = try(each.value.properties, null)

  dynamic "acl_configuration" {
    for_each = try(each.value.acl_configuration, null) != null ? ["true"] : []
    content {
      s3_acl_option = each.value.acl_configuration.s3_acl_option
    }
  }

  dynamic "encryption_configuration" {
    for_each = try(each.value.encryption_configuration, null) != null ? ["true"] : []
    content {
      encryption_option = each.value.encryption_configuration.encryption_option
      kms_key           = each.value.encryption_configuration.kms_key
    }
  }

  expected_bucket_owner = try(each.value.expected_bucket_owner, null)
  force_destroy         = try(each.value.force_destroy, false)

}

resource "aws_athena_data_catalog" "default" {
  for_each = local.enabled ? var.data_catalogs : {}

  name        = "${module.this.id}-${each.key}"
  description = each.value.description
  type        = each.value.type

  parameters = each.value.parameters

  tags = merge(
    module.this.tags,
    { Name = "${module.this.id}-${each.key}" }
  )
}

resource "aws_athena_named_query" "default" {
  for_each = local.enabled ? var.named_queries : {}

  name        = "${module.this.id}-${each.key}"
  workgroup   = aws_athena_workgroup.default[0].id
  database    = aws_athena_database.default[each.value.database].name
  query       = format(each.value.query, each.value.database)
  description = each.value.description
}
