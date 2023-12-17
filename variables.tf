variable "name" {}

variable "annotations" {
  type    = map(string)
  default = {}
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "rules" {
  type = list(object({
    api_groups        = list(string)
    resources         = list(string)
    verbs             = list(string)
    resource_names    = list(string)
    non_resource_urls = list(string)
  }))
}

variable "subject" {
  type = object({
    kind      = optional(string, "ServiceAccount")
    name      = string
    namespace = optional(string)
  })
  default = null
}