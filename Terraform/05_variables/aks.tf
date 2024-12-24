resource "azurerm_resource_group" "aksrg" {
    name        = var.rg_name       
    location    = var.rg_location   
}

resource "azurerm_container_registry" "acr" {
    name                = var.acr_name
    resource_group_name = azurerm_resource_group.aksrg.name
    location            = azurerm_resource_group.aksrg.location
    sku                 = var.acr_sku 
    admin_enabled       = true 
}

resource "azurerm_kubernetes_cluster" "aks" {
    name                = var.aks_name 
    resource_group_name = azurerm_resource_group.aksrg.name
    location            = azurerm_resource_group.aksrg.location
    dns_prefix          = "nextops"
    
    default_node_pool {
       name                 = "default"
       vm_size              = "Standard_DS2_v2"
       node_count           = "1"
       auto_scaling_enabled = "true"
       max_count            = "3"
       min_count            = "1"
    }

    network_profile {
       network_plugin       = "azure"
       network_plugin_mode  = "overlay"
       pod_cidr             = "10.10.0.0/16"
       network_policy       = "calico"
       load_balancer_sku    = "standard"
       service_cidr         = "10.11.0.0/16"
       dns_service_ip       = "10.11.0.10"
    }

    identity {
        type = "SystemAssigned"
    }     
}

resource "azurerm_role_assignment" "aks2acr" {
    principal_id        = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
    scope               = azurerm_container_registry.acr.id
    role_definition_name = "AcrPull"
    skip_service_principal_aad_check = true
}