resource "kubernetes_cluster_role_v1" "this" {
  metadata {
    name        = var.name
    annotations = var.annotations
    labels      = var.labels
  }

  dynamic "rule" {
    for_each = { for i, v in var.rules : i => v }
    content {
      api_groups        = rule.value.api_groups
      resources         = rule.value.resources
      resource_names    = rule.value.resource_names
      non_resource_urls = rule.value.non_resource_urls
      verbs             = rule.value.verbs
    }
  }
}

resource "kubernetes_cluster_role_binding_v1" "this" {
  count = var.subject == null ? 0 : 1

  metadata {
    name = var.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.name
  }

  subject {
    kind      = var.subject.kind
    name      = var.subject.name
    namespace = var.subject.namespace
  }
}

