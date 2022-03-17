resource "google_compute_instance_template" "wp-template" {
  name           = var.tamplate-name
  machine_type   = var.machine_type
  can_ip_forward = false
  
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image      = var.source_image
    auto_delete       = true
    boot              = true
    disk_size_gb      = var.disk_size_gb
  }

  network_interface {
    network = var.net
    subnetwork = var.sub-net
    
  }
  
  service_account {
    email  = var.sa
    scopes = ["cloud-platform"]
  }
  shielded_instance_config {
    enable_vtpm = true
    enable_integrity_monitoring = true
  }
  metadata_startup_script = file("./modules/instance-template/start-script")
}

