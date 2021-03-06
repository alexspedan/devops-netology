resource "yandex_vpc_network" "thesis" {
  name = "thesis"
}

resource "yandex_vpc_subnet" "primary" {
  name           = "primary"
  v4_cidr_blocks = ["10.10.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.thesis.id
}

resource "yandex_vpc_subnet" "secondary" {
  name           = "secondary"
  v4_cidr_blocks = ["10.10.22.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.thesis.id
}

resource "yandex_vpc_subnet" "backup" {
  name           = "backup"
  v4_cidr_blocks = ["10.10.30.0/24"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.thesis.id
}