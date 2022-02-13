resource "yandex_vpc_network" "thesis" {
  name = "thesis"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  v4_cidr_blocks = ["10.10.10.0/24"]
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.thesis.id
}

resource "yandex_vpc_subnet" "private" {
  name           = "private"
  v4_cidr_blocks = ["10.10.20.0/24"]
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.thesis.id
  route_table_id = yandex_vpc_route_table.private-rt.id
}

resource "yandex_vpc_route_table" "private-rt" {
  network_id = yandex_vpc_network.thesis.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "10.10.10.254"
  }
}