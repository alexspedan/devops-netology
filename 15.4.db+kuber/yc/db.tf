
resource "yandex_mdb_mysql_cluster" "netology" {
  name                = "netology"
  environment         = "PRESTABLE"
  network_id          = "netology"
  version             = "8.0"
  security_group_ids  = [ "<список групп безопасности>" ]
  deletion_protection = true

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = "20"
  }

  database {
    name = "netology_db"
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
    zone      = "<зона доступности>"
    subnet_id = "<идентификатор подсети>"
  }
}