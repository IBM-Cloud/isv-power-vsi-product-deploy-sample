data "ibm_pi_catalog_images" "catalog_images" {
  sap                  = true
  vtl                  = true
  pi_cloud_instance_id = local.pid
}

data "ibm_pi_images" "cloud_instance_images" {
  pi_cloud_instance_id = local.pid
}

locals {
  public_stock_image_name = "7300-00-01"
  catalog_image = [for x in data.ibm_pi_catalog_images.catalog_images.images : x if x.name == local.public_stock_image_name]
  cloud_inst_image = [for x in data.ibm_pi_images.cloud_instance_images.image_info : x if x.name == local.public_stock_image_name]
  stock_image_copy_id = length(local.cloud_inst_image) > 0 ? local.cloud_inst_image[0].id  : ""
  found_instance = [for x in data.ibm_pi_instances.cloud_instance_instances.pvm_instances : x if x.name == var.instance_name]
}

data "ibm_pi_key" "key" {
  pi_cloud_instance_id = local.pid
  pi_key_name          = var.ssh_key_name
}

data "ibm_pi_network" "power_network" {
  pi_cloud_instance_id = local.pid
  pi_network_name      = var.network_name
}

resource "ibm_pi_image" "power_stock_image_copy" {
  count = length(local.stock_image_copy_id) == 0 ? 1 : length(local.found_instance)
  pi_image_name       = local.public_stock_image_name
  pi_image_id         = local.catalog_image[0].image_id
  pi_cloud_instance_id = local.pid
}

resource "ibm_pi_instance" "instance" {
  pi_cloud_instance_id = local.pid
  pi_memory            = var.memory
  pi_processors        = var.processors
  pi_instance_name     = var.instance_name
  pi_proc_type         = var.processor_type
  pi_image_id          = length(local.stock_image_copy_id) == 0 ? ibm_pi_image.power_stock_image_copy[0].image_id : local.stock_image_copy_id
  pi_key_pair_name     = data.ibm_pi_key.key.id
  pi_sys_type          = var.sys_type
  pi_storage_type      = var.storage_type
  pi_network {
    network_id = data.ibm_pi_network.power_network.id
  }
  depends_on = [ ibm_pi_image.power_stock_image_copy ]
}
