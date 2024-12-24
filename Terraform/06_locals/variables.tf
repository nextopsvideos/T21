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

variable "vnet_name" {
    type = string  
}

variable "vnet_address_space" {
    type = list(string)  
}

variable "subnet1_name" {
    type = string 
}

variable "address_prefix" {
    type = list(string)
  
}