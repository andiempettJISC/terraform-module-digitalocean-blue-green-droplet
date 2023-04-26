resource "digitalocean_floating_ip" "main" {

  region = local.region
}

data "template_file" "userdata" {
  template = var.userdata_path != null ? file(var.userdata_path) : file("${abspath(path.root)}/userdata.yml")
  vars     = var.userdata_vars
}

resource "digitalocean_droplet" "blue" {
  count = var.color == "blue" || var.keep_inactive ? 1 : 0

  image         = local.latest_image
  name          = "${var.name}.blue.${local.domain}"
  region        = local.region
  size          = var.droplet_size
  monitoring    = true
  droplet_agent = true
  user_data     = data.template_file.userdata.rendered
  ssh_keys = [
    for value in data.digitalocean_ssh_keys.keys.ssh_keys :
    value.id
  ]

  tags = concat(var.tags, [
    "blue"
  ])

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      user_data,
      image,
      name,
      size,
      region,
      ssh_keys,
      tags
    ]
  }
}

resource "time_sleep" "blue_wait" {
  count      = var.color == "blue" || var.keep_inactive ? 1 : 0
  depends_on = [digitalocean_droplet.blue]

  create_duration  = var.create_wait_duration
  destroy_duration = var.destroy_wait_duration
}

resource "digitalocean_droplet" "green" {
  count = var.color == "green" || var.keep_inactive ? 1 : 0

  image         = local.latest_image
  name          = "${var.name}.green.${local.domain}"
  region        = local.region
  size          = var.droplet_size
  monitoring    = true
  droplet_agent = true
  user_data     = data.template_file.userdata.rendered
  ssh_keys = [
    for value in data.digitalocean_ssh_keys.keys.ssh_keys :
    value.id
  ]

  tags = concat(var.tags, [
    "green"
  ])

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      user_data,
      image,
      name,
      size,
      region,
      ssh_keys,
      tags
    ]
  }
}

resource "time_sleep" "green_wait" {
  count      = var.color == "green" || var.keep_inactive ? 1 : 0
  depends_on = [digitalocean_droplet.green]

  create_duration  = var.create_wait_duration
  destroy_duration = var.destroy_wait_duration
}

data "http" "health_blue" {
  count = var.enable_healthcheck && var.color == "blue" ? 1 : 0

  url = "${var.healthcheck_protocol}://${digitalocean_droplet.blue[0].ipv4_address}${var.healthcheck_path}"

  retry {
    attempts = 5
  }

  depends_on = [
    time_sleep.blue_wait
  ]
  request_headers = {
    Accept = var.healthcheck_content_type
  }
}

data "http" "health_green" {
  count = var.enable_healthcheck && var.color == "green" ? 1 : 0

  url = "${var.healthcheck_protocol}://${digitalocean_droplet.green[0].ipv4_address}${var.healthcheck_path}"

  retry {
    attempts = 5
  }

  depends_on = [
    time_sleep.green_wait
  ]
  request_headers = {
    Accept = var.healthcheck_content_type
  }
}

locals {
  promoted_droplet = var.color == "blue" ? digitalocean_droplet.blue : digitalocean_droplet.green
  demoted_droplet = var.color == "blue" ? digitalocean_droplet.green : digitalocean_droplet.blue
}

resource "null_resource" "provision_lb" {
  count = var.ansible != null && var.enable_healthcheck ? 1 : 0

  triggers = {
    servers = "${local.promoted_droplet[0].id}"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ansible.user} -i '${var.ansible.inventory}' ${var.ansible.playbook} --extra-vars '${var.ansible.extra_vars} promoted_ip=${local.promoted_droplet[0].ipv4_address_private} demoted_ip=${local.demoted_droplet[0].ipv4_address_private}'"
  }

  depends_on = [
    time_sleep.blue_wait,
    time_sleep.green_wait,
    data.http.health_blue,
    data.http.health_green
  ]
}

resource "null_resource" "provision_lb_no_healthcheck" {
  count = var.ansible != null && !var.enable_healthcheck ? 1 : 0

  triggers = {
    servers = "${local.promoted_droplet[0].id}"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.ansible.user} -i '${var.ansible.inventory}' ${var.ansible.playbook} --extra-vars '${var.ansible.extra_vars} promoted_ip=${local.promoted_droplet[0].ipv4_address_private} demoted_ip=${local.demoted_droplet[0].ipv4_address_private}'"
  }

  depends_on = [
    time_sleep.blue_wait,
    time_sleep.green_wait
  ]
}

resource "digitalocean_floating_ip_assignment" "main" {
  count = var.enable_healthcheck ? 1 : 0

  ip_address = digitalocean_floating_ip.main.ip_address
  droplet_id = var.color == "blue" ? digitalocean_droplet.blue[0].id : digitalocean_droplet.green[0].id
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    null_resource.provision_lb,
    time_sleep.blue_wait,
    time_sleep.green_wait,
    data.http.health_blue,
    data.http.health_green
  ]
}

resource "digitalocean_floating_ip_assignment" "no_health_check" {
  count = !var.enable_healthcheck ? 1 : 0

  ip_address = digitalocean_floating_ip.main.ip_address
  droplet_id = var.color == "blue" ? digitalocean_droplet.blue[0].id : digitalocean_droplet.green[0].id
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    time_sleep.blue_wait,
    time_sleep.green_wait
  ]
}