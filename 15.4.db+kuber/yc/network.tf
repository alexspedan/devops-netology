resource "yandex_vpc_subnet" "public" {
  name           = "test"
  v4_cidr_blocks = ["192.168.50.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.netology.id

resource "yandex_vpc_subnet" "public" {
  name           = "test"
  v4_cidr_blocks = ["192.168.60.0/24"]
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.netology.id