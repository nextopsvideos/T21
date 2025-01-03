variable "rgname"{
    type = string
    description = "used for naming resource group"
}

variable "location"{
    type = string
    description = "used for selecting location"
    default = "eastus"
}

variable "vnet_cidr_prefix" {
  type = string
  description = "This variable defines address space for vnet"
}