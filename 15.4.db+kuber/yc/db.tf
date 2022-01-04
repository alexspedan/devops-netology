
resource "yandex_mdb_mysql_cluster" "netology" {
  name                = "netology"
  environment         = "PRESTABLE"
  network_id          = "netology"
  version             = "8.0"
  security_group_ids  = [ "<список групп безопасности>" ]
  deletion_protection = true
  backup_window_start = 23:59

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-ssd"
    disk_size          = "20"
  }

  database {
    name = "netology_db"
  }
  maintenance_window {
    type = "ANYTIME"
  }
  user {
    name     = "netology"
    password = "netology"
    permission {
      database_name = "netology_db"
      roles         = ["ALL"]
    }
  }


  host {
    zone      = "ru-central1-a"
    name      = "host_name_a"
    priority  = 2
    subnet_id = yandex_vpc_subnet.a.id
    assign_public_ip = "true"
  }
  host {
    zone                    = "ru-central1-b"
    name                    = "host_name_b"
    replication_source_name = "host_name_c"
    subnet_id               = yandex_vpc_subnet.b.id
    assign_public_ip = "true"
  }
  host {
    zone      = "ru-central1-c"
    name      = "host_name_c"
    subnet_id = yandex_vpc_subnet.c.id
    assign_public_ip = "true"
  }
  host {
    zone      = "ru-central1-c"
    name      = "host_name_c_2"
    subnet_id = yandex_vpc_subnet.c.id
    assign_public_ip = "true"
  }