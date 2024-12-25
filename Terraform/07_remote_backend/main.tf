#terraform init
#terraform validate
#terraform plan
#terraform apply
#terraform destroy

# resource "type_of_the_resource" "code_block_name" {
     #attribute1 = "value1"
     #attribute2 = "value2"
# }

#Azure
resource "azurerm_resource_group" "myrg" {
    name     = "NextOpsRGT21"
    location = "eastus"

    tags = {
      "env" = "dev"
      "createby" = "Charan"
      "creationDate" = "12/24/2024"
    }
}