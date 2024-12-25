module "qa" {
    source = "../../webapp_module"
    rg_name     =  "QaRG"
    rg_location =  "westus"
    asp_name    =  "qaaspt21"
    app_name    =  "nextopsqaappt21"
    os_type     =  "Linux"
    sku_name    =  "B1"  
}