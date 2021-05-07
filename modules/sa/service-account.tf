resource "google_service_account" "service-account" {
  account_id   = "wordpress-account"
  display_name = "Wordpress Account"
}
output "email" { # output id network outside for ather module
  value = google_service_account.service-account.email
}
