resource "google_service_account" "service-account" {
  account_id   = var.name
  display_name = var.name
}
 
resource "google_project_iam_member" "project" {
  project = var.project
  role    = var.roles
  member  = "serviceAccount:${google_service_account.service-account.email}"
}