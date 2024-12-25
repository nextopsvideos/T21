resource "azurerm_resource_group" "webapprg" {
        name        = var.rg_name
        location    = var.rg_location
}

resource "azurerm_service_plan" "webappasp" {
        name                = var.asp_name
        resource_group_name = azurerm_resource_group.webapprg.name
        location            = azurerm_resource_group.webapprg.location
        sku_name            = var.sku_name 
        os_type             = var.os_type
}

resource "azurerm_linux_web_app" "linuxwebapp" {
        name                = var.app_name 
        resource_group_name = azurerm_resource_group.webapprg.name
        location            = azurerm_resource_group.webapprg.location
        service_plan_id     = azurerm_service_plan.webappasp.id

        site_config{ 
            
        } 
}