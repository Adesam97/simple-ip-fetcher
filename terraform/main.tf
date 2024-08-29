resource "aws_ecr_repository" "container_info_app" {
  name = "container-info-app"
}

resource "kubernetes_deployment" "container_info_app" {
  metadata {
    name = "container-info-app"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "container-info-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "container-info-app"
        }
      }

      spec {
        container {
          image = "${aws_ecr_repository.container_info_app.repository_url}:latest"
          name  = "container-info-app"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "container_info_app" {
  metadata {
    name = "container-info-app"
  }

  spec {
    selector = {
      app = kubernetes_deployment.container_info_app.spec.0.template.0.metadata.0.labels.app
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}