variable "docker_host" {
  type        = string
  default     = "unix:///var/run/docker.sock"
  description = "Where Terraform reaches out to talk to Docker"
}

#########################################
# Cloudflare
#########################################

variable "cloudflare_api_token" {
  type        = string
  description = "API Token for authenticating to Cloudflare"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID"
}

variable "domain_name" {
  type        = string
  description = "Domain name for hosting Jellyfin"
}

variable "subdomain" {
  type        = string
  default     = "jellyfin"
  description = "subdomain for hosting Jellyfin"
}

#########################################
# Jellyfin
#########################################

variable "jellyfin_port" {
  type    = string
  default = "8096"
}

variable "jellyfin_timezone" {
  type    = string
  default = "Etc/UTC"
}

variable "mediaserver_username" {
  type = string
}

variable "mediaserver_password" {
  type = string
}

variable "mediaserver_hostname" {
  type = string
}

variable "mediaserver_path" {
  type = string
}