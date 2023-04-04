module "blue-green-example" {
  source = "../"

  name         = "test-loadbalancer"
  droplet_size = "s-2vcpu-2gb"

  color         = "green"
  keep_inactive = false
}

output "ip" {
  value = module.blue-green-example.ip_address
}