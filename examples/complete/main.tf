module "example" {
  source = "../.."

  databases     = var.databases
  data_catalogs = var.data_catalogs
  named_queries = var.named_queries

  context = module.this.context
}
