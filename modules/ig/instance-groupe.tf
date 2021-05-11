variable "template" {
  type = string
}
variable "min-i" {
  type = number
}
variable "max-i" {
  type = number
}
resource "google_compute_region_instance_group_manager" "wordpress-ig" {
  name = "wordpress-groupe"
  base_instance_name = "wordpress-groupe"
  region = "europe-west1"
  distribution_policy_zones = [
    "europe-west1-d",
    "europe-west1-b",
    "europe-west1-c"]

  version {
    instance_template = var.template
  }

  named_port {
    name = "http"
    port = 80
  }
  auto_healing_policies {
    health_check = google_compute_health_check.wp-health-check.id
    initial_delay_sec = 300

  }
}

resource "google_compute_region_autoscaler" "wordpress-autoscaler" {
  name   = "wordpress-autoscaler"
  region = "europe-west1"
  target = google_compute_region_instance_group_manager.wordpress-ig.id
  autoscaling_policy {
    max_replicas    = var.max-i
    min_replicas    = var.min-i
    cooldown_period = 80
    cpu_utilization { target = 1 }
  }
}


resource "google_compute_health_check" "wp-health-check" {
  name                = "wordpres-health-check"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 4

  tcp_health_check {
    port = "80"
  }
}

output "wp-health" {
  value = [google_compute_health_check.wp-health-check.id]
}

output "ig-id" {
  value = google_compute_region_instance_group_manager.wordpress-ig.instance_group
}

