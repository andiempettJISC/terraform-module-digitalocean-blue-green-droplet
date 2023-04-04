locals {
  env          = terraform.workspace
  domain       = var.domain_name
  region       = var.region
  droplet_size = var.droplet_size

  latest_image = data.digitalocean_images.latest_image.images[0].id

}

data "digitalocean_ssh_keys" "keys" {}

data "digitalocean_images" "latest_image" {
  filter {
    key    = "private"
    values = ["true"]
  }
  filter {
    key      = "name"
    values   = ["${var.image_name}-*"]
    match_by = "re"
  }
  sort {
    key       = "created"
    direction = "desc"
  }
}