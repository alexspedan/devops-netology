resource "yandex_compute_instance" "k8s" {
  name = "master"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8uic3g6hoea6qc52d7"
      size = 14
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.primary.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker1" {
  name = "worker1"
  zone           = "ru-central1-b"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8uic3g6hoea6qc52d7"
      size = 14
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.secondary.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker2" {
  name = "worker2"
  zone           = "ru-central1-c"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8uic3g6hoea6qc52d7"
      size = 14
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.backup.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}