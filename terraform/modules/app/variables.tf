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
  description = "Google compute instance zone"
  default     = "europe-west1-b"
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_ip {
  description = "Mongo db instance ip address"
}

variable enable_deploy {
  description = "Deploy app boolean"
  default     = 0
}
