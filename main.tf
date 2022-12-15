resource "kubernetes_cluster_role" "this" {
  metadata {
    name = var.name
  }
  dynamic "rule" {
    for_each = { for i, v in var.rules : i => v }
    content {
      api_groups        = try(rule.value["api_groups"], null)
      resources         = try(rule.value["resources"], null)
      resource_names    = try(rule.value["resource_names"], null)
      non_resource_urls = try(rule.value["non_resource_urls"], null)
      verbs             = try(rule.value["verbs"], null)
    }
  }
}