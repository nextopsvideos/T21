module "dev" {
    source = "../../webapp_module"
    rg_name     =  "DevRG"
    rg_location =  "westus"
    asp_name    =  "nextopsdevaspt22"
    app_name    =  "nextopsdevappt21"
    os_type     =  "Linux"
    sku_name    =  "B1"  
}