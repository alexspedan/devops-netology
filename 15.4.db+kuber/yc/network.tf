resource "yandex_vpc_subnet" "a" {
  name           = "test"
  v4_cidr_blocks = ["192.168.50.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.netology.id

resource "yandex_vpc_subnet" "b" {
  name           = "test"
  v4_cidr_blocks = ["192.168.60.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.netology.id

resource "yandex_vpc_subnet" "c" {
  name           = "test"
  v4_cidr_blocks = ["192.168.70.0/24"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.netology.id  