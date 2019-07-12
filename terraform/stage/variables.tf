variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

variable project {
  description = "My Project"
}

variable region {
  description = "Region"

  # Значение по умолчанию
  default = "europe-west1"
}

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

variable "node_count" {
  #Описание переменной
  description = "google compute instance count"
  default     = "1"
}
