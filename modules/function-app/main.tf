# Resource group for this environment
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.resource_prefix}-${var.environment}"
  location = var.location
}

# Storage account required by Azure Functions
resource "azurerm_storage_account" "main" {
  name                     = "${var.resource_prefix}fn${var.environment}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# The Function App service plan (consumption = pay per use)
resource "azurerm_service_plan" "main" {
  name                = "plan-${var.resource_prefix}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

# The actual Function App
resource "azurerm_linux_function_app" "main" {
  name                = "func-${var.resource_prefix}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location

  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  service_plan_id            = azurerm_service_plan.main.id

  app_settings = {
    ENVIRONMENT = var.environment
  }

  site_config {
    application_stack {
      node_version = "20"
    }
  }
}
