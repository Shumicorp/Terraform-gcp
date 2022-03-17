resource "google_storage_bucket" "my-buck" {
  name          = var.name-backet
  location      = var.location
  uniform_bucket_level_access = true
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.my-buck.name
  role = var.st-role
  member = "serviceAccount:${var.sa}"
  depends_on = [google_storage_bucket.my-buck]
}
