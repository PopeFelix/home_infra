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
    default = "alpine-3.20.3-wiht-ssh-20240912.tar.xz"
}

#Establish which nic you would like to utilize
variable "nic_name" {
    default = "vmbr0"
}


# Needed for remote exec
variable "ssh_keys" {
    default = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDjuXJsm20610XQGaGgsagEupVlfzYMorJXrNo1u7Gx took@oscar
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjUArrNxdmrCsL4RHnChkj4r4ZO/aT1ZN2uatKEwO7q aurelia@Aurelias-MBP.scurrilous.foo
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFvTxWlvvqFcVFSfCCTfmC61Z7Dzkuk0t5s8dos4/Bb took@brook
EOF
}

# I don't have VLANs set up
# #Establish the VLAN you'd like to use
# variable "vlan_num" {
#     default = "place_vlan_number_here"
# }


variable "fileserver_root_password" {
}
