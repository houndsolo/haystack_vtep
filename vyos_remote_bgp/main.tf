locals {
  bgp_system_as = var.bgp_system_as
  peer_group_name = "vxlan_peer"
}

resource "vyos_protocols_bgp" "enable_bgp" {
  system_as = local.bgp_system_as
}

resource "vyos_protocols_bgp_address_family_ipv4_unicast_maximum_paths" "bgp_multipath" {
  depends_on = [vyos_protocols_bgp.enable_bgp]
  ebgp = 1
  ibgp = 1
}


resource "vyos_protocols_bgp_address_family_l2vpn_evpn" "l2vpn_evpn_config" {
  depends_on = [vyos_protocols_bgp.enable_bgp]
  advertise_all_vni = true
  advertise_svi_ip = true
  rt_auto_derive = true
}

resource "vyos_protocols_bgp_address_family_l2vpn_evpn_flooding" "l2vpn_evpn_flooding" {
  depends_on = [vyos_protocols_bgp_address_family_l2vpn_evpn.l2vpn_evpn_config]
  disable = var.bgp_l2vpn_flooding_disable
  head_end_replication = var.bgp_l2vpn_her
}

resource "vyos_protocols_bgp_peer_group" "lylat_peer" {
  depends_on = [vyos_protocols_bgp.enable_bgp]
  identifier = {peer_group = local.peer_group_name }
  ebgp_multihop = 6
  address_family = {
    l2vpn_evpn = {}
    ipv4_unicast = {
      soft_reconfiguration = {inbound = true}
    }
  }
}

resource "vyos_protocols_bgp_address_family_l2vpn_evpn_vni" "vni_6" {
  depends_on = [vyos_protocols_bgp_address_family_l2vpn_evpn.l2vpn_evpn_config]
  identifier = { vni = 6 }
  advertise_default_gw = true
  advertise_svi_ip     = true

}

resource "vyos_protocols_bgp_neighbor" "dark_triad_neighbor" {
  depends_on = [vyos_protocols_bgp_peer_group.lylat_peer]
  identifier = { neighbor = var.remote_peer_ip }
  remote_as = 780
  peer_group = local.peer_group_name
}

