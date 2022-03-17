locals {
  # for provider
  project = "gcp101091-mrusn"
  region  = "europe-west1"
  # for module Service-Account
  sa-name = "test-2"
  sa-role = "roles/editor"
  # for module VPC-Network
  vpc_name        = "my-vpc"
  subnet1-name    = "subnet-1"
  subnet1-ip_cidr = "10.0.10.0/24"
  subnet1-region  = "europe-west1"
  subnet2-name    = "subnet-2-with-privat-access"
  subnet2-ip_cidr = "10.0.20.0/24"
  subnet2-region  = "europe-west2"
  # for DataBase
  db-service-name  = "namedatabase-service"
  db-instance-type = "db-f1-micro"
  db-user-name     = "test"
  db-user-pass     = "1234"
  db-database-name = "test"
  # for storage-bucket
  name-backet = "Test"
  location    = "EU"
  st-role     = "roles/storage.admin"
  # for instance template
  tamplate-name = "test"
  machine_type  = "e2-medium"
  source_image  = "ubuntu-1804-bionic-v20210415"
  disk_size_gb  = 10
  # for instance groupe
  mig-name                  = "test-groupe"
  distribution_policy_zones = ["europe-west1-d", "europe-west1-b", "europe-west1-c"]
  autoscaler-name           = "test-autoscaler"
  autoscaler-region         = "europe-west1"
  mig-region                = "europe-west1"
  health-check-name         = "health-check"
  health-check-port         = "80"
  autoscaler-min            = 2
  autoscaler-max            = 4
  # for load-balancer
  lb-name       = "test"
  ssl-cert-name = "mrsun-ssl-test"
  ssl-domains   = ["mrusn.pp.ua."]
  # for dns
  dns-name = "mrusn.pp.ua."
  dns-type = "A"
}
