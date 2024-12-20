variable "bgp_system_as" {
  type = number
}
variable  "remote_peer_ip" {
  type = string
}
variable  "host_peer_ip" {
  type = string
}
variable  "pve_node" {
  type = string
}
variable "vtep_count" {
  type = number
  default = 6
}

variable "host_node" {
  description = "Information about the host node."
  type = object({
    id   = number  # Assuming 'id' is a numeric value. Change to 'string' if it's alphanumeric.
    name = string
  })
}
variable "bgp_l2vpn_her" {
  type = bool
}
variable "bgp_l2vpn_flooding_disable" {
  type = bool
}
