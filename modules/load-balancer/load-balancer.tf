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

resource "google_compute_url_map" "default" {
  name            = "wordpress-map"
  default_service = google_compute_backend_service.wordpress-backend.id
}

resource "google_compute_target_https_proxy" "https-proxy" {
  name             = "test-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}
resource "google_compute_managed_ssl_certificate" "default" {
  name = "mrusn-ssl-terra"

  managed {
    domains = ["mrusn.pp.ua."]
  }
}

resource "google_compute_global_forwarding_rule" "load-balancer-https" {
  name                  = "https-role"
  ip_address            = google_compute_global_address.wordpress-front.address
  port_range            = "443"
  target                = google_compute_target_https_proxy.https-proxy.id
}

