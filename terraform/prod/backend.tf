terraform {
  backend "gcs" {
    bucket = "reddit-app-bucket"
    prefix = "prod"
  }
}
