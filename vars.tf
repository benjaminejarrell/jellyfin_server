variable "docker_host" {
  type        = string
  default     = "unix:///var/run/docker.sock"
  description = "Docker management socker"
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
  description = "Subdomain for hosting Jellyfin"
}

#########################################
# Jellyfin
#########################################

variable "jellyfin_port" {
  type    = string
  default = "8096"
  description = "Internal facing Jellyfin port"
}

variable "jellyfin_timezone" {
  type    = string
  default = "Etc/UTC"
  description = "Jellyfin Timezone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones"
}

#########################################
# Media Server Connection
#########################################

# Cifs (Windows/Samba)

variable "mediaserver_cifs_enabled" {
  type = bool
  default = false
  description = "Mount a cifs media server on Jellyfin. If this is enabled, mediaserver_cifs* must be configured"
}

variable "mediaserver_cifs_username" {
  type = string
  default = ""
}

variable "mediaserver_cifs_password" {
  type = string
  default = ""
}

variable "mediaserver_cifs_hostname" {
  type = string
  default = ""
}

variable "mediaserver_cifs_path" {
  type = string
  default = ""
}
#NFS 
variable "mediaserver_nfs_enabled" {
  type = bool
  default = false
  description = "Mount an NFS media server on Jellyfin. If this is enabled, mediaserver_nfs* must be configured"
}

variable "mediaserver_nfs_device" {
  type = string
  default = ""
}

variable "mediaserver_nfs_address" {
  type = string
  default = ""
  description = "Address of the NFS host, IP or hostname."
}

variable "mediaserver_nfs_options" {
  type = string
  default = ""
  description = "Additional NFS options, comma delmited."
}

variable "mediaserver_nfs_path" {
  type = string
  default = ""
}