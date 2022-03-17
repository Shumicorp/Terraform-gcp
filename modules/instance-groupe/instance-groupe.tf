resource "google_compute_region_instance_group_manager" "mig" {
  name = var.mig-name
  base_instance_name = "${var.mig-name}-groupe"
  region = var.mig-region
  distribution_policy_zones = var.distribution_policy_zones
  version {
    instance_template = var.template
  }

  named_port {
    name = "http"
    port = 80
  }
  auto_healing_policies {
    health_check = google_compute_health_check.health-check.id
    initial_delay_sec = 300

  }
}

resource "google_compute_region_autoscaler" "autoscaler" {
  name   = var.autoscaler-name
  region = var.autoscaler-region

  target = google_compute_region_instance_group_manager.mig.id
  autoscaling_policy {
    max_replicas    = var.autoscaler-max
    min_replicas    = var.autoscaler-min
    cooldown_period = 80
    cpu_utilization { target = 1 }
  }
}


resource "google_compute_health_check" "health-check" {
  name                = var.health-check-name
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 4

  tcp_health_check {
    port = "${var.health-check-port}"
  }
}



