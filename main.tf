locals {
  vxlan_mtu = 1350
  disable_arp_filter = false
  disable_forwarding = false
  enable_arp_accept = false
  enable_arp_announce = false
  enable_directed_broadcast = true
  enable_proxy_arp = false
  proxy_arp_pvlan = false

  vxlan_external = true
  vxlan_neighbor_suppress = false
  vxlan_nolearning = false
  vxlan_vni_filter = false

  bgp_l2vpn_flooding_disable = true
  bgp_l2vpn_her = false



  pve_node = "pve"
  hostname = "haystack_vtep"
  host_peer_ip = "10.69.69.1/24"
  remote_peer_ip = "10.240.255.80"
  node_id = 80
  bgp_system_as = 121

}

module "vtep_remote_vyos_init" {
  #depends_on = [module.remote_vtep]
  source = "./vyos_remote_init"
  providers = { vyos = vyos.remote }
  host_node = {
    id = local.node_id
    name = local.hostname
  }
  pve_node = local.pve_node
  host_peer_ip = local.host_peer_ip
  remote_peer_ip = local.remote_peer_ip
}

module "vtep_remote_vyos_bgp" {
  depends_on = [module.vtep_remote_vyos_init]
  source = "./vyos_remote_bgp"
  providers = { vyos = vyos.remote }
  host_node = {
    id = local.node_id
    name = local.hostname
  }
  pve_node = local.pve_node
  host_peer_ip = local.host_peer_ip
  remote_peer_ip = local.remote_peer_ip
  bgp_l2vpn_her = local.bgp_l2vpn_her
  bgp_l2vpn_flooding_disable = local.bgp_l2vpn_flooding_disable
  bgp_system_as = local.bgp_system_as
}


module "vtep_remote_vyos_vxlan" {
  depends_on = [module.vtep_remote_vyos_bgp]
  source = "./vyos_remote_vxlan"
  providers = { vyos = vyos.remote }
  host_node = {
    id = local.node_id
    name = local.hostname
  }
  pve_node = local.pve_node
  host_peer_ip = local.host_peer_ip
  remote_peer_ip = local.remote_peer_ip

  vxlan_mtu = local.vxlan_mtu
  disable_arp_filter = local.disable_arp_filter
  disable_forwarding = local.disable_forwarding
  enable_arp_accept = local.enable_arp_accept
  enable_arp_announce = local.enable_arp_announce
  enable_directed_broadcast = local.enable_directed_broadcast
  enable_proxy_arp = local.enable_proxy_arp
  proxy_arp_pvlan = local.proxy_arp_pvlan
  vxlan_external = local.vxlan_external
  vxlan_neighbor_suppress = local.vxlan_neighbor_suppress
  vxlan_nolearning = local.vxlan_nolearning
  vxlan_vni_filter = local.vxlan_vni_filter
}
#
