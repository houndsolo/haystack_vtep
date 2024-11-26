locals {
  dum0_network = "10.240.255.${var.host_node.id}/32"
  bgp_system_as = 700 + var.host_node.id
}
resource "vyos_system" "host_parameters" {
  domain_name = "lylat.space"
  domain_search = ["lylat.space"]
  host_name = "vtep-remote"
}


#resource "vyos_system_ipv6" "disable_ipv6" {
#  disable_forwarding = true
#}


#resource "vyos_interfaces_ethernet_vif" "link_to_lan" {
#  identifier = {
#    ethernet = "eth1"
#    vif = 1080
#  }
#  description = "link to lan"
#}
#
