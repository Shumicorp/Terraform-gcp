resource "google_service_account" "service-account" {
  account_id   = "wordpress-account"
  display_name = "Wordpress Account"
}
