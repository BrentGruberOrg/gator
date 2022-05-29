resource "digitalocean_droplet" "caddy" {
  count  = var.droplet_count
  image  = var.image
  name   = "www-${count.index}"
  region = var.region
  size   = var.size
  ssh_keys = [
    data.digitalocean_ssh_key.mbp.id,
    data.digitalocean_ssh_key.desk.id,
    data.digitalocean_ssh_key.mist.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    agent       = true
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "scripts/tailscale.sh"
    destination = "/tmp/tailscale.sh"
  }

  provisioner "file" {
    source      = "scripts/caddy.sh"
    destination = "/tmp/caddy.sh"
  }

  provisioner "file" {
    source      = "scripts/Caddyfile"
    destination = "/tmp/Caddyfile"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/tailscale.sh",
      "/tmp/tailscale.sh ${var.TAILSCALE_TOKEN}",
      "chmod +x /tmp/caddy.sh",
      "/tmp/caddy.sh"
    ]
  }
}

resource "digitalocean_loadbalancer" "www-lb" {
  name   = "www-lb"
  region = var.region

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 443
    target_protocol = "https"

    tls_passthrough = true
  }


  healthcheck {
    port     = 22
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