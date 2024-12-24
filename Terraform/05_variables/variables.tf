# variable syntax
# variable "variable_name" {
#    type = string #type of the value
#    description = "description for the variable" 
#    default = "default_value"
# }

variable "rg_name" {
   type = string
   description = "the name of the resource group"
   #default = "AKSRG"
}

variable "rg_location" {
    type = string 
    description = "the location of the resource group"
}

variable "acr_name" {
    type = string   
}

variable "acr_sku" {
    type = string  
}

variable "aks_name" {
    type = string  
}
