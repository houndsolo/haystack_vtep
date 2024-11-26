provider "vyos" {
  alias = "remote"
  endpoint ="https://10.20.121.10"
  api_key  = var.vyos_key
  certificate = {
    disable_verify = true
  }
  default_timeouts = 2
  overwrite_existing_resources_on_create = true
}
