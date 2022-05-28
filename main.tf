resource "digitalocean_droplet" "caddy" {
    count = 2
    image = "ubuntu-20-04-x64"
    name = "www-${count.index}"
    region = "nyc3"
    size = "s-1vcpu-1gb"
    ssh_keys = [
      data.digitalocean_ssh_key.mbp.id
    ]

    connection {
        host = self.ipv4_address
        user = "root"
        type = "ssh"
        private_key = file(var.pvt_key)
        timeout = "2m"
    }

    provisioner "file" {
        source = "tailscale.sh"
        destination = "/tmp/tailscale.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/tailscale.sh",
            "/tmp/tailscale.sh ${var.TAILSCALE_TOKEN}",
        ]
  }
}

resource "digitalocean_loadbalancer" "www-lb" {
  name = "www-lb"
  region = "nyc3"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 80
    target_protocol = "http"
  }
  

  healthcheck {
    port = 22
    protocol = "tcp"
  }

  droplet_ids = digitalocean_droplet.caddy[*].id
}


resource "digitalocean_record" "wildcard" {
  domain = var.DO_DOMAIN
  type   = "A"
  name   = "*"
  value  = digitalocean_loadbalancer.www-lb.ip
}