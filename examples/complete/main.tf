module "example" {
  source = "../.."

  database_name = var.database_name

  context = module.this.context
}
