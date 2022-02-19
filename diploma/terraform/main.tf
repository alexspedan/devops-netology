terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "apedan-private-storage-sausage-store"
    region     = "us-east-1"
    key        = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud
  folder_id = var.yc_folder
  zone      = "ru-central1-a"
}

// Create SA
resource "yandex_iam_service_account" "diploma" {
  folder_id = var.yc_folder
  name      = "tf-diploma-sa"
}

// Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "diploma-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Use keys to create bucket
resource "yandex_storage_bucket" "diploma" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "diploma-storage"
  acl    = "private"
}