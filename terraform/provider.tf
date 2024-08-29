# Configure the Azure provider
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

# Configure remote state
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate${random_string.resource_code.result}"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

# Generate random string for unique storage account name
resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

# Create resource group for tfstate
resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate"
  location = "East US"
}

# Create storage account for tfstate
resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

# Create container for tfstate
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}
