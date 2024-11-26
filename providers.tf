terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.66.3"
    }
    vyos = {
      source = "registry.terraform.io/thomasfinstad/vyos-rolling"
      version = "9.0.202411130"
    }
  }
}

