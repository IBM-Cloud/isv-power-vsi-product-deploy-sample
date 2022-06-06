variable "crn" {
  type        = string
  description = "Power Systems Virtual Server CRN"
}
variable "region" {
  type        = string
  default     = "dal"
  description = "The region that belongs to the PowerVS instance"
}
variable "license_repository_capacity" {
  type        = number
  default     = 1
  description = "The VTL license repository capacity in terabyte value"
}
variable "memory" {
  type        = number
  default     = 16
  description = "The amount of memory that you want to assign to your VTL in gigabytes.  Use the following formula: memory >= 16 + (2 * license_repository_capacity)"
}
variable "processors" {
  type        = number
  default     = 2
  description = "The number of vCPUs to assign to the VTL as visible within the guest Operating System"
}
variable "instance_name" {
  type        = string
  default     = "my_catalog_vtl"
  description = "The name to assign to the VTL instance"
}
variable "processor_type" {
  type        = string
  default     = "shared"
  description = "The type of processor mode in which the VTL will run with 'shared', 'capped' or 'dedicated'"
}
variable "sys_type" {
  type        = string
  default     = "s922"
  description = "The type of system on which to create the VTL: 's922', 'e880', 'e980', 'e1080', or 's1022'"
}
variable "storage_type" {
  type        = string
  default     = "tier1"
  description = "The type of storage tier to assign for storage volume performance: 'tier1' or 'tier3'"
}
variable "ssh_key_name" {
  type        = string
  description = "The name of the public SSH RSA key to use when creating the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
variable "network_name" {
  type        = string
  description = "The network ID or name to assign to the VTL instance, as defined for the selected Power Systems Virtual Server CRN"
}
