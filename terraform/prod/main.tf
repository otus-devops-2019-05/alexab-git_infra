provider "google" {
  #Provider version
  version = "2.0.0"

  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  private_key     = "${var.private_key}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
  db_ip           = "${module.db.internal_ip}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  private_key     = "${var.private_key}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source = "../modules/vpc"

  source_ranges = ["90.154.71.173/32"]
}
