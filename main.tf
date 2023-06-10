locals {
  cloudflare_tunnel_secret = base64encode(random_string.cloudflare_tunnel_secret.result)
  url                      = "https://${var.subdomain}.${var.domain_name}"
}


resource "random_string" "cloudflare_tunnel_secret" {
  length  = 40
  special = false
}

#########################################
# Docker
#########################################

provider "docker" {
  host = var.docker_host
}

resource "docker_image" "jellyfin" {
  name = "lscr.io/linuxserver/jellyfin:latest"
}

resource "docker_image" "cloudflared" {
  name = "cloudflare/cloudflared:latest"
}

#########################################
# Jellyfin
#########################################

resource "docker_container" "jellyfin" {
  image   = docker_image.jellyfin.image_id
  name    = "Jellyfin"
  restart = "unless-stopped"

  ports {
    internal = var.jellyfin_port
  }

  env = [
    "JELLYFIN_PublishedServerUrl=${local.url}",
    "PUID=1000",
    "PGID=1000",
    "TZ=${var.jellyfin_timezone}"
  ]


  volumes {
    container_path = "/config"
    volume_name    = docker_volume.data.name
  }

  volumes {
    container_path = "/data/tvshows"
    volume_name    = docker_volume.media.name
  }

  volumes {
    container_path = "/data/movies"
    volume_name    = docker_volume.media.name
  }
}

#Local data storage
resource "docker_volume" "data" {
  name = "jellyfin_data"
}

#Media Server
resource "docker_volume" "media" {
  name = "jellyfin_media"
  driver_opts = {
    type   = "cifs"
    device = var.mediaserver_path
    o      = "username=${var.mediaserver_username},password=${var.mediaserver_password},addr=${var.mediaserver_hostname}"
  }
}


#########################################
# Cloudflared Container
#########################################

resource "docker_container" "cloudflared" {
  image   = docker_image.cloudflared.image_id
  name    = "Cloudflared"
  restart = "unless-stopped"

  command = ["tunnel", "run"] #Pass "tunnel run" to the startup command

  env = [
    "TUNNEL_TOKEN=${cloudflare_tunnel.docker.tunnel_token}" #Token used to auth with Cloudflare
  ]


  depends_on = [cloudflare_tunnel.docker] #Make sure we create the tunnel in Cloudflare first
}

#########################################
# Cloudflare Cloud
#########################################

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

data "cloudflare_accounts" "main" {
  name = var.cloudflare_account_id
}

resource "cloudflare_tunnel" "docker" {
  account_id = var.cloudflare_account_id
  name       = "jellyfin-docker"
  secret     = local.cloudflare_tunnel_secret
}

data "cloudflare_zone" "jellyfin" {
  name = var.domain_name
}

locals {
  jellyfin_fqdn = "${var.subdomain}.${var.domain_name}"
}

resource "cloudflare_tunnel_config" "example_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.docker.id

  config {
    ingress_rule {
      hostname = local.jellyfin_fqdn
      service  = "http://host.docker.internal:${var.jellyfin_port}"
    }
    ingress_rule {
      service = "http://8.8.8.8:8080" #catch all null route
    }
  }
}

#########################################
# DNS
#########################################

resource "cloudflare_record" "jellyfin" {
  zone_id = data.cloudflare_zone.jellyfin.zone_id
  name    = var.subdomain
  value   = "${cloudflare_tunnel.docker.id}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
