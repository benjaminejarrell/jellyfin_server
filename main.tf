provider "docker" {
  host = var.docker_host
}

resource "docker_container" "jellyfin" {
  image = docker_image.jellyfin.image_id
  name  = "Jellyfin"

  ports {
    internal = "8096"
    external = "8096"
  }
}
