resource "yandex_kms_symmetric_key" "key-a" {
  name              = "netology practice"
  description       = "to ecrypt bucket"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // 1 year
}

resource "yandex_storage_bucket" "netology" {
  bucket = "netology"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}