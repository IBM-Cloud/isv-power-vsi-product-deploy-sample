data "ibm_pi_catalog_images" "catalog_images" {
  sap                  = true
  vtl                  = true
  pi_cloud_instance_id = local.pid
}

data "ibm_pi_images" "cloud_instance_images" {
  pi_cloud_instance_id = local.pid
}

data "ibm_pi_placement_groups" "cloud_instance_groups" {
  pi_cloud_instance_id = local.pid
}

locals {
  stock_image_name = "VTL-FalconStor-10_03-001"
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.stock_image_name]
  private_image = [for x in data.ibm_pi_images.cloud_instance_images.image_info : x if x.name == local.stock_image_name]
  private_image_id = length(local.private_image) > 0 ? local.private_image[0].id  : ""
  placement_group = [for x in data.ibm_pi_placement_groups.cloud_instance_groups.placement_groups : x if x.name == var.placement_group]
  placement_group_id = length(local.placement_group) > 0 ? local.placement_group[0].id : ""
}

data "ibm_pi_key" "key" {
  pi_cloud_instance_id = local.pid
  pi_key_name          = var.ssh_key_name
}

data "ibm_pi_network" "private_network" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.private_network
}

data "ibm_pi_network" "public_network" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.public_network
}

resource "ibm_pi_image" "stock_image_copy" {
  count = length(local.private_image_id) == 0 ? 1 : 0

  pi_image_name       = local.stock_image_name
  pi_image_id         = local.catalog_image[0].image_id
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_placement_group_id = local.placement_group_id
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = var.instance_name
  pi_proc_type         = var.processor_type
  pi_image_id          = length(local.private_image_id) == 0 ? ibm_pi_image.stock_image_copy[0].image_id : local.private_image_id
  pi_key_pair_name     = data.ibm_pi_key.key.id
  pi_sys_type          = var.sys_type
  pi_storage_type      = var.storage_type
  pi_network {
    network_id = data.ibm_pi_network.public_network.id
  }
  pi_network {
    network_id = data.ibm_pi_network.private_network.id
  }
  pi_license_repository_capacity = var.license_repository_capacity
}
