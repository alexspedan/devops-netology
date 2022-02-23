resource "yandex_compute_instance" "k8s" {
  name = "master"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8uic3g6hoea6qc52d7"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.primary.id
    nat       = true
  }

  metadata = {
    ssh-keys = "alekseipedan:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "k8s1" {
  name = "worker1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8uic3g6hoea6qc52d7"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.secondary.id
    nat       = true
  }

  metadata = {
    ssh-keys = "alekseipedan:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "k8s2" {
  name = "worker2"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8uic3g6hoea6qc52d7"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.backup.id
    nat       = true
  }

  metadata = {
    ssh-keys = "alekseipedan:${file("~/.ssh/id_rsa.pub")}"
  }
}