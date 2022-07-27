variable "region" {
  type = string
}

variable "databases" {
  type = map(any)
}

variable "data_catalogs" {
  type = map(any)
}

variable "named_queries" {
  type = map(map(string))
}
