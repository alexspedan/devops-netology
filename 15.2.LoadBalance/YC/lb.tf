resource "yandex_lb_network_load_balancer" "web" {
  name = "web-network-load-balancer"

  listener {
    name = "web-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.group-web.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = ""
      }
    }
  }
}