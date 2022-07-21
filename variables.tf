variable "vpc-name" {
  type    = string
  default = "my-vpc"
}
variable "vpc-subnet1" {
  type        = string
  default     = "subnet-1"
  description = "subnetwork without private access"
}
variable "vpc-subnet1-ip_cidr" {
  type    = string
  default = "10.0.10.0/24"
  description = "IP range"
}
variable "vpc-subnet1-region" {
  type    = string
  default = "europe-west1"
}
variable "vpc-subnet2" {
  type        = string
  default     = "subnet-2-with-pa"
  description = "subnetwork with private access"
}
variable "vpc-subnet2-ip_cidr" {
  type    = string
  default = "10.0.20.0/24"
  description = "IP range"
}
variable "vpc-subnet2-region" {
  type    = string
  default = "europe-west2"
}
variable "firewall-name" {
  type    = string
  default = "test-firewall"
}
variable "firewall-source_ranges" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}
variable "firewall-allow-protocol" {
  type    = string
  default = "tcp"
}
variable "firewall-allow-ports" {
  type    = list(any)
  default = ["8080", "443", "22"]
}
variable "service-account-name" {
  type    = string
  default = "test-ac"
}
variable "service-account-roles" {
  type    = string
  default = "roles/editor"
}
variable "db-service-name" {
  type    = string
  default = "SQL-service"
}
variable "db-user-name" {
  type    = string
  default = "admin"
}
variable "db-user-pass" {
  type    = string
  default = "admin"
}
variable "db-instance-type" {
  type    = string
  default = "db-f1-micro"
}
variable "db-database-name" {
  type    = string
  default = "test"
}
variable "name-backet" {
  type    = string
  default = "Test-storage-backet"
}
variable "location-backet" {
  type    = string
  default = "EU"
}
variable "sa-backet-role" {
  type    = string
  default = "roles/storage.admin"
  description = "Service account role for backet"
}
variable "tamplate-name" {
  type    = string
  default = "templ-name"
}
variable "template-machine_type" {
  type    = string
  default = "e2-medium"
  description = "machine_type for template"
}
variable "tamplate-source_image" {
  type    = string
  default = "ubuntu-1804-bionic-v20210415"
}
variable "mig-name" {
  type    = string
  default = "mig-groupe"
  description = "Managed instance group"
}
variable "mig-region" {
  type    = string
  default = "europe-west1"
}
variable "zones-for-mig" {
  type    = list
  default = ["europe-west1-d", "europe-west1-b", "europe-west1-c"]
}
variable "lb-name" {
  type    = string
  default = "lb-test"
  description = "LoadBalancer name"
}
variable "ssl-cert-name" {
  type    = string
  default = "mrusn.pp.ua"
}
variable "ssl-domains" {
  type    = list
  default = ["mrusn.pp.ua."]
}
variable "dns-name" {
  type    = string
    default = "mrusn.pp.ua."
}
variable "dns-type" {
  type    = string
  default = "A"
}