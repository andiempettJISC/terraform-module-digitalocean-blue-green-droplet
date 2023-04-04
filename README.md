<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_common-metadata"></a> [common-metadata](#module\_common-metadata) | ../common-metadata | n/a |

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.blue](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_droplet.green](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_floating_ip.main](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip) | resource |
| [digitalocean_floating_ip_assignment.main](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip_assignment) | resource |
| [digitalocean_floating_ip_assignment.no_health_check](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip_assignment) | resource |
| [null_resource.provision_lb](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.provision_lb_no_healthcheck](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [time_sleep.blue_wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [time_sleep.green_wait](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [digitalocean_images.latest_image](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/images) | data source |
| [digitalocean_ssh_keys.keys](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_keys) | data source |
| [http_http.health_blue](https://registry.terraform.io/providers/hashicorp/http/3.1.0/docs/data-sources/http) | data source |
| [http_http.health_green](https://registry.terraform.io/providers/hashicorp/http/3.1.0/docs/data-sources/http) | data source |
| [template_file.userdata](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible"></a> [ansible](#input\_ansible) | n/a | `map(string)` | `null` | no |
| <a name="input_color"></a> [color](#input\_color) | n/a | `string` | n/a | yes |
| <a name="input_create_wait_duration"></a> [create\_wait\_duration](#input\_create\_wait\_duration) | n/a | `string` | `"1m"` | no |
| <a name="input_destroy_wait_duration"></a> [destroy\_wait\_duration](#input\_destroy\_wait\_duration) | n/a | `string` | `"1m"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | `"example.com"` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | n/a | `any` | n/a | yes |
| <a name="input_enable_healthcheck"></a> [enable\_healthcheck](#input\_enable\_healthcheck) | n/a | `bool` | `true` | no |
| <a name="input_healthcheck_content_type"></a> [healthcheck\_content\_type](#input\_healthcheck\_content\_type) | n/a | `string` | `"text/*"` | no |
| <a name="input_healthcheck_path"></a> [healthcheck\_path](#input\_healthcheck\_path) | n/a | `string` | `""` | no |
| <a name="input_healthcheck_protocol"></a> [healthcheck\_protocol](#input\_healthcheck\_protocol) | n/a | `string` | `"http"` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | n/a | `string` | `"ubuntu-20-04-x64"` | no |
| <a name="input_keep_inactive"></a> [keep\_inactive](#input\_keep\_inactive) | n/a | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"lon1"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list` | `[]` | no |
| <a name="input_userdata_path"></a> [userdata\_path](#input\_userdata\_path) | n/a | `any` | `null` | no |
| <a name="input_userdata_vars"></a> [userdata\_vars](#input\_userdata\_vars) | n/a | `map(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_active_color"></a> [active\_color](#output\_active\_color) | n/a |
| <a name="output_active_droplet_id"></a> [active\_droplet\_id](#output\_active\_droplet\_id) | n/a |
| <a name="output_active_internal_ip_address"></a> [active\_internal\_ip\_address](#output\_active\_internal\_ip\_address) | n/a |
| <a name="output_active_name"></a> [active\_name](#output\_active\_name) | n/a |
| <a name="output_active_private_ip_address"></a> [active\_private\_ip\_address](#output\_active\_private\_ip\_address) | n/a |
| <a name="output_blue_ip_address"></a> [blue\_ip\_address](#output\_blue\_ip\_address) | n/a |
| <a name="output_demoted"></a> [demoted](#output\_demoted) | n/a |
| <a name="output_green_ip_address"></a> [green\_ip\_address](#output\_green\_ip\_address) | n/a |
| <a name="output_healthcheck_response_body"></a> [healthcheck\_response\_body](#output\_healthcheck\_response\_body) | n/a |
| <a name="output_healthcheck_response_headers"></a> [healthcheck\_response\_headers](#output\_healthcheck\_response\_headers) | n/a |
| <a name="output_ip_address"></a> [ip\_address](#output\_ip\_address) | n/a |
| <a name="output_promoted"></a> [promoted](#output\_promoted) | n/a |
<!-- END_TF_DOCS -->