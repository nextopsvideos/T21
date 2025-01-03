resource "azurerm_resource_group" "myrg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_mysql_flexible_server" "mysql" {
  name                   = "nextopsmysql01"
  resource_group_name    = azurerm_resource_group.myrg.name
  location               = azurerm_resource_group.myrg.location
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  backup_retention_days  = 7
  delegated_subnet_id    = azurerm_subnet.myrg.id
  private_dns_zone_id    = azurerm_private_dns_zone.myrg.id
  sku_name               = "GP_Standard_D2ds_v4"  
}

resource "null_resource" "nr1" {
   triggers = {
     db_ready = azurerm_mysql_flexible_server.mysql.fqdn
   }
}

resource "azurerm_service_plan" "myasp" {
  name                = var.asp_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  depends_on = [ null_resource.nr1 ]
}

resource "azurerm_linux_web_app" "myapp" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_service_plan.myasp.location
  service_plan_id     = azurerm_service_plan.myasp.id

  site_config {}
}