variable "DO_TOKEN" {}
variable "DO_DOMAIN" {}
variable "TAILSCALE_TOKEN" {}
variable "GCLOUD_TOKEN" {}
variable "GCLOUD_PASSWORD" {}
variable "GCLOUD_METRICS_USER" {}
variable "GCLOUD_LOGS_USER" {}
variable "GCLOUD_TRACES_USER" {}
variable "GAGENT_PROFILE" {}
variable "image" {
  default = "ubuntu-20-04-x64"
}
variable "region" {
  default = "nyc3"
}
variable "size" {
  default = "s-1vcpu-1gb"
}
variable "droplet_count" {
  default = 1
}