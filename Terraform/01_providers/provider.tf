# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.14.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}

  # client_id       = "92d947f1-089b-4deb-b0b7-d4dee0612cc6"
  # client_secret   = "ywj8Q~L8L~uULgqlnjelT9za5GdDY_UFpi0uJc-I"
  # tenant_id       = "9085ff8c-8807-4ff8-a403-ea470525cda6"
  # subscription_id = "5c5f2b33-138d-47aa-b0e4-9b9fd849425a"
 
}

#az ad sp create-for-rbac --name tfuser1 --role="Contributor" --scopes="/subscriptions/xxxxxx-xxxxxx-xxxxxx-xxx-xxx"