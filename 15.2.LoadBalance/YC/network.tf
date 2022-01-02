resource "yandex_vpc_network" "netology" {
  name = "netology"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id
}

resource "yandex_vpc_subnet" "test" {
  name           = "test"
  v4_cidr_blocks = ["192.168.30.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id
}