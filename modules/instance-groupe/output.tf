output "wp-health" {
  value = [google_compute_health_check.wp-health-check.id]
}

output "ig-id" {
  value = google_compute_region_instance_group_manager.wordpress-ig.instance_group
}