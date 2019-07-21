resource "google_compute_firewall" "reddit_firewall_ssh" {
  name    = "default-allow-reddit-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.source_ranges}"
}
