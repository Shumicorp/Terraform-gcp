resource "google_sql_database_instance" "mysql" {
  name                = var.db-service-name
  region              = "europe-west1"
  database_version    = "MYSQL_5_7"
  deletion_protection = "false"
  settings {
    tier = "${var.db-instance-type}"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc-net
    }
  }
  
}
resource "google_sql_user" "users" {
  name       = var.db-user-name
  instance   = google_sql_database_instance.mysql.name
  host       = "%"
  password   = var.db-user-pass
  depends_on = [google_sql_database_instance.mysql]
}
resource "google_sql_database" "database" {
  name       = var.db-database-name
  instance   = google_sql_database_instance.mysql.name
  depends_on = [google_sql_database_instance.mysql]
}



