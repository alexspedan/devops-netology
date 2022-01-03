resource "yandex_vpc_network" "load-balance" {
  name = "load-balance"
}

resource "yandex_vpc_subnet" "public-lb" {
  name           = "public-lb"
  v4_cidr_blocks = ["192.168.30.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.load-balance.id
}

resource "yandex_vpc_subnet" "test" {
  name           = "test"
  v4_cidr_blocks = ["192.168.40.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.load-balance.id
}