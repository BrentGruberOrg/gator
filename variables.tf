variable "DO_TOKEN" {}
variable "DO_DOMAIN" {}
variable "TAILSCALE_TOKEN" {}
variable "pvt_key" {}
variable "image" {
  default = "ubuntu-20-04-x64"
}
variable "region" {
  default = "nyc3"
}
variable "size" {
  default = "s-1vcpu-1gb"
}
variable "count" {
  default = 1
}