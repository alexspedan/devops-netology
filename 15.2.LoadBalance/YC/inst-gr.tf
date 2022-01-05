resource "yandex_compute_instance_group" "group-web" {
  name                = "group-web"
  folder_id           = var.yc_folder
  service_account_id  = "${yandex_iam_service_account.sa.id}"
  deletion_protection = true
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }
    network_interface {
      network_id = yandex_vpc_network.load-balance.id
      subnet_ids = [yandex_vpc_subnet.public-lb.id]
    }

    }
    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
      user-data = "${file("./bootstrap.sh")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}