resource "google_storage_bucket" "my-buck" {
  name          = var.name-backet
  location      = "EU"
  uniform_bucket_level_access = true
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.my-buck.name
  role = "roles/storage.admin"
  member = "serviceAccount:${var.acc}"
  depends_on = [google_storage_bucket.my-buck]
}
