terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = var.DO_TOKEN
}

data "digitalocean_ssh_key" "mbp" {
  name = "mbp"
}