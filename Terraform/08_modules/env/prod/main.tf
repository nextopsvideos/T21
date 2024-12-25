module "prod" {
    source = "../../webapp_module"
    rg_name     =  "ProdRG"
    rg_location =  "westus"
    asp_name    =  "prodaspt21"
    app_name    =  "nextopsprodappt21"
    os_type     =  "Linux"
    sku_name    =  "B1"  
}