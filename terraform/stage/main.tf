provider "google" {
  #Provider version
  version = "2.0.0"

  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  private_key     = "${var.private_key}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  private_key     = "${var.private_key}"
  db_ip           = "${module.db.internal_ip}"
}

module "vpc" {
  source        = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}
