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
    resource_group_name  = "myTerraformStateRG124334545346"
    storage_account_name = "iptfstatestore123245646"
    container_name       = "terrastate323456533"
    key                  = "terraform.tfstate"
  }
}
