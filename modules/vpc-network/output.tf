output "id" { # output id network outside for ather module
  value = google_compute_network.vpc_network.id
}
output "sub1-id" { # output id network outside for ather module
  value = google_compute_subnetwork.private-subnet.id
}
output "sub2-id" { # output id network outside for ather module
  value = google_compute_subnetwork.public-subnet.id
}