variable "lb-name" {
  type = string
}

variable "mig-id" {
  type = string
  description = "id instance groupe"
}
variable "check" {
  type = list
  description = "health check"
}
variable "ssl-cert-name" {
  type = string
}

variable "ssl-domains"{
  type = list
  default = []
}