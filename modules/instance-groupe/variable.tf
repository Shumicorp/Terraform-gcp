variable "template" {
  type = string
  description = "ip-instance template"
}
variable "min-i" {
  type = number
  description = "number of minimum replicas for autoscaler"
}
variable "max-i" {
  type = number
  description = "number of maximum replicas for autoscaler"
}