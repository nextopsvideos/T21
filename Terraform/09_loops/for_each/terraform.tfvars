resourcedetails = {
  "eastus" = {
      rg_name           = "eastusRG"
      rg_location       = "eastus"
      vnet_name         = "eastvnet"
      address_space     = ["10.20.0.0/16"]
      subnet_name       = "eastsubnet"
      address_prefix    = ["10.20.0.0/24"]
      vm_name           = "eastvm"
      size              = "Standard_B1s"   
  }
  "westus" = {
      rg_name           = "westusRG"
      rg_location       = "westus"
      vnet_name         = "westvnet"
      address_space     = ["10.30.0.0/16"]
      subnet_name       = "westsubnet"
      address_prefix    = ["10.30.0.0/24"]
      vm_name           = "westvm"
      size              = "Standard_B2s"   
  }
}