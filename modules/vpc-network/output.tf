output "id" { # output id network outside for ather module
  value = google_compute_network.vpc_network.id
}
output "sub-id" { # output id network outside for ather module
  value = google_compute_subnetwork.private-subnet.id
}