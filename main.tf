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
data "ibm_pi_key" "key" {
  pi_cloud_instance_id = local.pid
  pi_key_name          = var.ssh_key_name
}
data "ibm_pi_network" "network_1" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_1
}
data "ibm_pi_network" "network_2" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_2
}
data "ibm_pi_network" "network_3" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_3
}

locals {
  stock_image_name = "VTL-FalconStor-10_03-001"
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.stock_image_name]
  private_image = [for x in data.ibm_pi_images.cloud_instance_images.image_info : x if x.name == local.stock_image_name]
  private_image_id = length(local.private_image) > 0 ? local.private_image[0].id  : ""
  placement_group = [for x in data.ibm_pi_placement_groups.cloud_instance_groups.placement_groups : x if x.name == var.placement_group]
  placement_group_id = length(local.placement_group) > 0 ? local.placement_group[0].id : ""
}

resource "ibm_pi_image" "stock_image_copy" {
  count = length(local.private_image_id) == 0 ? 1 : 0

  pi_image_name       = local.stock_image_name
  pi_image_id         = local.catalog_image[0].image_id
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = var.instance_name
  pi_proc_type         = var.processor_type
  pi_image_id          = length(local.private_image_id) == 0 ? ibm_pi_image.stock_image_copy[0].image_id : local.private_image_id
  pi_sys_type          = var.sys_type
  pi_storage_type      = var.storage_type
  pi_key_pair_name     = length(data.ibm_pi_key.key) > 0 ? data.ibm_pi_key.key.id : null
  pi_affinity_policy   = length(var.affinity_policy) > 0 ? var.affinity_policy : null
  pi_anti_affinity_instances = length(var.pvm_instances) > 0 ? var.pvm_instances : null
  pi_placement_group_id = local.placement_group_id
  pi_license_repository_capacity = var.license_repository_capacity
  dynamic "pi_network" {
    for_each = data.ibm_pi_network.network_1 == null ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_1.id
    }
  }
  dynamic "pi_network" {
    for_each = data.ibm_pi_network.network_2 == null ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_2.id
    }
  }
  dynamic "pi_network" {
    for_each = data.ibm_pi_network.network_3 == null ? [] : [1]
    content {
      network_id = data.ibm_pi_network.network_3.id
    }
  }

}
