variable "name" {
    type = string
}
variable "subnet1-name" {
    type = string
}
variable "subnet1-ip_cidr" {
    type = string
}
variable "subnet1-region" {
    type = string
}
variable "subnet2-name" {
    type = string
}
variable "subnet2-ip_cidr" {
    type = string
}
variable "subnet2-region" {
    type = string
}
variable "firewall-source_ranges" {
    type = list
    default = []
}
variable "firewall-name" {
    type = string
}
variable "firewall-allow-ports" {
    type = list
    default = []
}