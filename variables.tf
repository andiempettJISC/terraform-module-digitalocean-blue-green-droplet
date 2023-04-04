variable "color" {
  type = string
  validation {
    condition     = contains(["blue", "green"], var.color)
    error_message = "Must either be a blue or green deployment."
  }
}

variable "keep_inactive" {
  default = true
}

variable "create_wait_duration" {
  default = "1m"
}

variable "destroy_wait_duration" {
  default = "1m"
}

variable "enable_healthcheck" {
  default = true
}

variable "healthcheck_protocol" {
  default = "http"
}

variable "healthcheck_path" {
  default = ""
}

variable "healthcheck_content_type" {
  default = "text/*"
  validation {
    condition     = contains(["text/*", "application/json"], var.healthcheck_content_type)
    error_message = "Incorrect http healthcheck content-type content type. See https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http."
  }
}

variable "droplet_size" {
}

variable "region" {
  default = "lon1"
}

variable "name" {
}

variable "tags" {
  default = []
}

variable "userdata_path" {
  default = null
}

variable "userdata_vars" {
  type    = map(string)
  default = null
}

variable "image_name" {
  default = "ubuntu-20-04-x64"
}

variable "ansible" {
  default = null
  type = map(string)
}

variable "domain_name" {
  default = "example.com"
}