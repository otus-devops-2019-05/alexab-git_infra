variable public_key_path {
  # Описание переменной
  description = "Path to the public key used for ssh access"
}

variable private_key {
  # Описание переменной
  description = "Path to the private key used for ssh access"
}

variable zone {
  # Описание переменной
  description = "google compute instance zone"
  default     = "europe-west1-b"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
