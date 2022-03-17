variable "vpc-net" {
  type = string
  description = "id - vpc-network"
}
variable "db-service-name" {
  type = string
  description = "name database"
}
variable "db-instance-type" {
  type = string
}
variable "db-user-name" {
  type = string
  description = "id - vpc-network"
}
variable "db-user-pass" {
  type = string
  description = "id - vpc-network"
  sensitive = true
}
variable "db-database-name" {
  type = string
  description = "id - vpc-network"
}
