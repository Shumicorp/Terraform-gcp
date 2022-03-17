output "front-ip" { # output id network outside for ather module
  value = [google_compute_global_address.front.address]
}