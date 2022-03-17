variable "mig-name" {
  type = string
}
variable "mig-region" {
  type = string
}
variable "distribution_policy_zones" {
  type = list
  default = []
}
variable "template" {
  type = string
  description = "ip-instance template"
}
variable "autoscaler-name" {
  type = string
}
variable "autoscaler-region" {
  type = string
}
variable "autoscaler-min" {
  type = number
  description = "number of minimum replicas for autoscaler"
}
variable "autoscaler-max" {
  type = number
  description = "number of maximum replicas for autoscaler"
}
variable "health-check-name" {
  type = string
}
variable "health-check-port" {
  type = string
}