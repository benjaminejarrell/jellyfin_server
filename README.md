### Jellyfin Server
Set's up a publicly accessible [Jellyfin](https://jellyfin.org/) server behind a Cloudflare Zero Trust [Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/)

Cloudflare doesn't like pushing too much media over its network. 
Don't use the free plan for commercial use or you may have your account closed.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | ~>4.0 |
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | ~>3.0.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | ~>4.0 |
| <a name="provider_docker"></a> [docker](#provider\_docker) | ~>3.0.2 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudflare_record.jellyfin](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/record) | resource |
| [cloudflare_tunnel.docker](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/tunnel) | resource |
| [cloudflare_tunnel_config.jellyfin](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/tunnel_config) | resource |
| [docker_container.cloudflared](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container) | resource |
| [docker_container.jellyfin](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container) | resource |
| [docker_image.cloudflared](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [docker_image.jellyfin](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [docker_volume.data](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/volume) | resource |
| [docker_volume.media](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/volume) | resource |
| [random_string.cloudflare_tunnel_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [cloudflare_accounts.main](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/accounts) | data source |
| [cloudflare_zone.jellyfin](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_account_id"></a> [cloudflare\_account\_id](#input\_cloudflare\_account\_id) | Cloudflare account ID | `string` | n/a | yes |
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | API Token for authenticating to Cloudflare | `string` | n/a | yes |
| <a name="input_docker_host"></a> [docker\_host](#input\_docker\_host) | Docker management socker | `string` | `"unix:///var/run/docker.sock"` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name for hosting Jellyfin | `string` | n/a | yes |
| <a name="input_jellyfin_port"></a> [jellyfin\_port](#input\_jellyfin\_port) | Internal facing Jellyfin port | `string` | `"8096"` | no |
| <a name="input_jellyfin_timezone"></a> [jellyfin\_timezone](#input\_jellyfin\_timezone) | Jellyfin Timezone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones | `string` | `"Etc/UTC"` | no |
| <a name="input_mediaserver_cifs_enabled"></a> [mediaserver\_cifs\_enabled](#input\_mediaserver\_cifs\_enabled) | Mount a cifs media server on Jellyfin. If this is enabled, mediaserver\_cifs* must be configured | `bool` | `false` | no |
| <a name="input_mediaserver_cifs_hostname"></a> [mediaserver\_cifs\_hostname](#input\_mediaserver\_cifs\_hostname) | n/a | `string` | `""` | no |
| <a name="input_mediaserver_cifs_password"></a> [mediaserver\_cifs\_password](#input\_mediaserver\_cifs\_password) | n/a | `string` | `""` | no |
| <a name="input_mediaserver_cifs_path"></a> [mediaserver\_cifs\_path](#input\_mediaserver\_cifs\_path) | n/a | `string` | `""` | no |
| <a name="input_mediaserver_cifs_username"></a> [mediaserver\_cifs\_username](#input\_mediaserver\_cifs\_username) | n/a | `string` | `""` | no |
| <a name="input_mediaserver_nfs_address"></a> [mediaserver\_nfs\_address](#input\_mediaserver\_nfs\_address) | Address of the NFS host, IP or hostname. | `string` | `""` | no |
| <a name="input_mediaserver_nfs_device"></a> [mediaserver\_nfs\_device](#input\_mediaserver\_nfs\_device) | n/a | `string` | `""` | no |
| <a name="input_mediaserver_nfs_enabled"></a> [mediaserver\_nfs\_enabled](#input\_mediaserver\_nfs\_enabled) | Mount an NFS media server on Jellyfin. If this is enabled, mediaserver\_nfs* must be configured | `bool` | `false` | no |
| <a name="input_mediaserver_nfs_options"></a> [mediaserver\_nfs\_options](#input\_mediaserver\_nfs\_options) | Additional NFS options, comma delmited. | `string` | `""` | no |
| <a name="input_mediaserver_nfs_path"></a> [mediaserver\_nfs\_path](#input\_mediaserver\_nfs\_path) | n/a | `string` | `""` | no |
| <a name="input_mediaserver_paths"></a> [mediaserver\_paths](#input\_mediaserver\_paths) | List of directories on your media server where your content is hosted. | `list(string)` | <pre>[<br>  "/data/tvshows",<br>  "/data/movies"<br>]</pre> | no |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | Subdomain for hosting Jellyfin | `string` | `"jellyfin"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_URL"></a> [URL](#output\_URL) | User accessible URL of the media server |
| <a name="output_cloudflared_container_ID"></a> [cloudflared\_container\_ID](#output\_cloudflared\_container\_ID) | ID of the Cloudflared Docker Container |
| <a name="output_jellyfin_container_ID"></a> [jellyfin\_container\_ID](#output\_jellyfin\_container\_ID) | ID of the Jellyfin Docker container |
<!-- END_TF_DOCS -->
