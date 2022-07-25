module "example" {
  source = "../.."

  databases = var.databases

  context = module.this.context
}
