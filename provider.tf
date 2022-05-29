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

data "digitalocean_ssh_key" "desk" {
  name = "desk"
}

// Add the mist key so that mist is able to form a connection
data "digitalocean_ssh_key" "mist" {
  name = "mist"
}