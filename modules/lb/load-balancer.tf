variable "ig-id" {
  type = string
}
variable "check" {
  type = list
}

resource "google_compute_global_address" "wordpress-front" {
  name = "wordpress-front"
}

resource "google_compute_backend_service" "wordpress-backend" {
  backend {
    group           = var.ig-id
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
  name        = "wordpress-backend"
  health_checks = var.check
  
}

resource "google_compute_global_forwarding_rule" "load-balancer-rule" {
  name                  = "wordpress-forwarding-rule"
  ip_address            = google_compute_global_address.wordpress-front.address
  port_range            = "80"
  target                = google_compute_target_http_proxy.http-proxy.id
}

resource "google_compute_target_http_proxy" "http-proxy" {
  name    = "wordpress-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name            = "wordpress-map"
  default_service = google_compute_backend_service.wordpress-backend.id
}

