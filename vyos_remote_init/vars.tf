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

