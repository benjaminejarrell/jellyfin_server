output "URL" {
  value       = local.url
  description = "User accessible URL of the media server"
}

output "jellyfin_container_ID" {
  value       = docker_container.jellyfin.id
  description = "ID of the Jellyfin Docker container"
}

output "cloudflared_container_ID" {
  value       = docker_container.cloudflared.id
  description = "ID of the Cloudflared Docker Container"
}
