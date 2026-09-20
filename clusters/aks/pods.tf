resource "kubernetes_pod_v1" "demo-nginx" {
  metadata {
    name = "terraform-example"
  }

  spec {
    container {
      image = "nginx:1.31.6"
      name  = "example"
    }
  }
}
