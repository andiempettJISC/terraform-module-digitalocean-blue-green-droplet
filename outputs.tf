output "healthcheck_response_headers" {
  value = var.enable_healthcheck ? (var.color == "blue" ? data.http.health_blue[0].response_headers : data.http.health_green[0].response_headers) : {}
}

output "healthcheck_response_body" {
  value = var.enable_healthcheck ? (var.color == "blue" ? tolist([data.http.health_blue[0].response_body]) : tolist([data.http.health_green[0].response_body])) : []
}

output "ip_address" {
  value = digitalocean_floating_ip.main.ip_address
}

output "active_internal_ip_address" {
  value = var.color == "blue" ? digitalocean_droplet.blue[0].ipv4_address : digitalocean_droplet.green[0].ipv4_address
}

output "active_private_ip_address" {
  value = var.color == "blue" ? digitalocean_droplet.blue[0].ipv4_address_private : digitalocean_droplet.green[0].ipv4_address_private
}

output "active_droplet_id" {
  value = var.color == "blue" ? digitalocean_droplet.blue[0].id : digitalocean_droplet.green[0].id
}

output "blue_ip_address" {
  value = var.color == "blue" ? digitalocean_droplet.blue[0].ipv4_address : null
}

output "green_ip_address" {
  value = var.color == "green" ? digitalocean_droplet.green[0].ipv4_address : null
}

output "active_color" {
  value = var.color
}

output "active_name" {
  value = var.color == "blue" ? digitalocean_droplet.blue[0].name : digitalocean_droplet.green[0].name
}

output "demoted" {
  value = local.demoted_droplet
}

output "promoted" {
  value = local.promoted_droplet
}