terraform {
  required_providers {
     azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0.2"
    }
  }
  required_version = ">1.1.0"
  
  backend "azurerm" {
    resource_group_name  = "ayan-drift-test"
    storage_account_name = "stateastracc"
    container_name       = "tfstate"
    key                  = "project2.tfstate"
    use_azuread_auth     = true
  }
  
}

provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "trg_name" {
    name = var.rg_name
    location = var.rg_location
  
}

resource "azurerm_resource_group" "trgcount_name" {
    count = 2
    
    name = "${var.rg_name}${count.index}01"
    location = var.rg_location
  
}



variable "rggroupnam" {
  type = map(string)

  default = {
    dev   = "ayan.rg_namedev"
    qa    = "ayan.rg_name502qa"
    prod  = "ayan.rg_name503prod"
  }
}

resource "azurerm_resource_group" "trgforeaach_name" {
  for_each = var.rggroupnam

  name     = each.value
  location = var.rg_location
}






/* 

resource "azurerm_network_security_group" "NSG1" {
  name                = "ayan-nsg001"
  location            = var.rg_location
  resource_group_name = azurerm_resource_group.trg_name.name
#   depends_on = [ azurerm_resource_group.trg_name ]

}

locals {
  nsg_name = "ayan-nsg002"
  nsg_location = var.rg_location
  str_name = "stracc"
}

resource "azurerm_network_security_group" "NSG2" {
  name                = local.nsg_name
  location            = local.nsg_location
  resource_group_name = azurerm_resource_group.trg_name.name
#   depends_on = [ azurerm_resource_group.trg_name ]

}

resource "azurerm_storage_account" "state_str_acc" {
  name                     = "${var.state_str_acc}${local.str_name}"
  resource_group_name      = azurerm_resource_group.trg_name.name
  location                 = local.nsg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on = [ azurerm_resource_group.trg_name ]

  tags = {
    environment = "staging"
  }
}

*/




