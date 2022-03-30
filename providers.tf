terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
    }
  }
}

locals {
  pvs_info = split(":", var.crn)
  location = local.pvs_info[5]
  region   = can(regex("-", local.location)) ? (can(regex("-[0-9]+$", local.location)) ? replace(local.location, regex("-[0-9]+$", local.location), "") : local.location) : (can(regex("[0-9]+$", local.location)) ? replace(local.location, regex("[0-9]+$", local.location), "") : local.location)
  pid      = local.pvs_info[7]
}

provider "ibm" {
  region = local.region
  zone   = local.location
}
