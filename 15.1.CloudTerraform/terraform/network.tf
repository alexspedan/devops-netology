resource "yandex_vpc_network" "test" {
  name = "test"
}

resource "yandex_vpc_subnet" "public" {
  name = "public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.test.id
}

resource "yandex_vpc_subnet" "private" {
  name = "private"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.test.id
}