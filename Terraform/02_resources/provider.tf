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

  # client_id       = "xxxxxx-xxxxxx-xxxxxx-xxx-xxx"
  # client_secret   = "xxxxxx-xxxxxx-xxxxxx-xxx-xxx"
  # tenant_id       = "xxxxxx-xxxxxx-xxxxxx-xxx-xxx"
  subscription_id   = "xxxxxx-xxxxxx-xxxxxx-xxx-xxx"
 
}

#az ad sp create-for-rbac --name tfuser1 --role="Contributor" --scopes="/subscriptions/xxxxxx-xxxxxx-xxxxxx-xxx-xxx"