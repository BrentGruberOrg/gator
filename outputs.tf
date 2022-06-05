output "do_droplet_ids" {
    value = ["${digitalocean_droplet.caddy.*.id}"]
}

output "do_droplet_urns" {
    value = ["${digitalocean_droplet.caddy.*.urn}"]
}

output "do_droplet_names" {
    value = ["${digitalocean_droplet.caddy.*.urn}"]
}