resource "google_service_account" "service-account" {
  account_id   = "wordpress-account"
  display_name = "Wordpress Account" 
}
 
resource "google_project_iam_member" "project" {
  project = "my-elk-wp-softserve"
  role    = "roles/editor"
  member  = "serviceAccount:${google_service_account.service-account.email}"
}