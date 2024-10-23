variable "region" {
  description = "The AWS region."
  type        = string
}

variable "databases" {
  description = "Map of Athena databases and related configuration."
  type        = map(any)
}

variable "data_catalogs" {
  description = "Map of Athena data catalogs and related configuration."
  type        = map(any)
}

variable "named_queries" {
  description = "Map of Athena named queries and related configuration."
  type        = map(map(string))
}
