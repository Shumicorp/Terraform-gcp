output "health" {
  value = [google_compute_health_check.health-check.id]
}

output "mig-id" {
  value = google_compute_region_instance_group_manager.mig.instance_group
}