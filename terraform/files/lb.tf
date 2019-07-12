resource "google_compute_target_http_proxy" "reddit_lb_proxy" {
  name    = "reddit-lb-proxy"
  url_map = "${google_compute_url_map.reddit_web_map.self_link}"
}

resource "google_compute_url_map" "reddit_web_map" {
  name            = "reddit-web-map"
  default_service = "${google_compute_backend_service.reddit_service.self_link}"
}

resource "google_compute_global_forwarding_rule" "reddit_fwd_rule" {
  name       = "reddit-forwarding-rule"
  target     = "${google_compute_target_http_proxy.reddit_lb_proxy.self_link}"
  port_range = "80"
}

resource "google_compute_health_check" "reddit_health" {
  name                = "reddit-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10

  http_health_check {
    request_path = "/"
    port         = "9292"
  }
}

resource "google_compute_instance_group" "reddit_group" {
  name = "reddit-instance-group"
  zone = "${var.zone}"

  instances = ["${google_compute_instance.app.*.self_link}"]

  named_port {
    name = "http-9292"
    port = "9292"
  }
}

resource "google_compute_backend_service" "reddit_service" {
  name      = "reddit-service"
  port_name = "http-9292"
  protocol  = "HTTP"

  backend {
    group = "${google_compute_instance_group.reddit_group.self_link}"
  }

  health_checks = [
    "${google_compute_health_check.reddit_health.self_link}",
  ]
}
