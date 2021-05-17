variable "net" {
  type = string
}
variable "sub-net" {
  type = string
}
variable "acc" {
  type = string
}

resource "google_compute_instance_template" "wp-template" {
  name           = "wp-template"
  machine_type   = "e2-medium"
  can_ip_forward = false
  
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image      = "ubuntu-1804-bionic-v20210415"
    auto_delete       = true
    boot              = true
    disk_size_gb      = 10
  }

  network_interface {
    network = var.net
    subnetwork = var.sub-net
    
  }
  
  service_account {
    email  = var.acc
    scopes = ["cloud-platform"]
  }
  shielded_instance_config {
    enable_vtpm = true
    enable_integrity_monitoring = true
  }
  metadata_startup_script = file("./modules/tm/start-script")
}
output "id" {
  value = google_compute_instance_template.wp-template.id
}
