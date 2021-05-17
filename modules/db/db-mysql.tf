variable "net" {
  type = string
}
resource "google_sql_database_instance" "mysql" {
  name                = "wordpress-88" # name of database
  region              = "europe-west1"
  database_version    = "MYSQL_5_7"
  deletion_protection = "false"
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.net
    }
  }
  
}
resource "google_sql_user" "users" {
  name       = "mn"
  instance   = google_sql_database_instance.mysql.name
  host       = "%"
  password   = "1234"
  depends_on = [google_sql_database_instance.mysql]
}
resource "google_sql_database" "database" {
  name       = "wordpress"
  instance   = google_sql_database_instance.mysql.name
  depends_on = [google_sql_database_instance.mysql]
}



