# TF vars for spinning up VMs

variable "vm_name" {
    default = "cloud-init-test1"
}

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
    default = "vmbr1"
}

# Number of VMs to spin up
variable "vm_count" {
    default = 1
}

# Needed for remote exec
variable "ssh_keys" {
    default = <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJDjuXJsm20610XQGaGgsagEupVlfzYMorJXrNo1u7Gx took@oscar
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJjUArrNxdmrCsL4RHnChkj4r4ZO/aT1ZN2uatKEwO7q aurelia@Aurelias-MBP.scurrilous.foo
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFvTxWlvvqFcVFSfCCTfmC61Z7Dzkuk0t5s8dos4/Bb took@brook
EOF
}

#Establish the VLAN you'd like to use 
variable "vlan_num" {
    default = "place_vlan_number_here"
}

#Blank var for use by terraform.tfvars
variable "token_secret" {
}

#Blank var for use by terraform.tfvars
variable "token_id" {
}
