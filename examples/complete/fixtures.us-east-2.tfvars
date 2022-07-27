region = "us-east-2"

namespace = "eg"

environment = "ue2"

stage = "test"

name = "example"

databases = [
  database1 = {
    force_destroy = true
    properties = {
      custom_prop_1 = "example"
    }
  }
]

data_catalogs = {
  glue1 = {
    description = "This is an example to test Terraform"
    type: "GLUE"
    parameters:
      catalog-id: "123456789012"
  }
}

named_queries = {
  query1 = {
    database = "database1"
    description = "This is an example query to test Terraform"
    query = "SELECT * FROM %s limit 10;"
  }
}
