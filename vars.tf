# TF vars for spinning up VMs

variable "pm_tls_insecure" {
  description = "Set to true to ignore certificate errors"
  type        = bool
  default     = true
}

#Establish which Proxmox host you'd like to spin a VM up on
variable "proxmox_host" {
    default = "thebeast"
}

#Specify which template name you'd like to use
variable "template_name" {
    default = "ubuntu-2404-base"
}
#Establish which nic you would like to utilize
variable "nic_name" {
    default = "vmbr0"
}

# I don't have VLANs set up
# #Establish the VLAN you'd like to use 
# variable "vlan_num" {
#     default = "place_vlan_number_here"
# }

#Blank var for use by terraform.tfvars
variable "token_secret" {
}

#Blank var for use by terraform.tfvars
variable "token_id" {
}
