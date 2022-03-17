variable "net" {
  type = string
  description = "id vpc-network"
}
variable "sub-net" {
  type = string
  description = "id private-subnetwork"
}
variable "sa" {
  type = string
  description = "service account for API access"
}
variable "tamplate-name" {
  type = string
}
variable "machine_type" {
  type = string
}

variable "source_image" {
  type = string 
}
variable "disk_size_gb" {
  type = number
}