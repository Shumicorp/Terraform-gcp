variable "ip" {
  type = list
  description = "ip-address from load balancer(front-service)"
}
variable "dns-name" {
  type =string
}
variable "dns-type" {
  type =string
}