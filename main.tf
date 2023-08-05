terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = "2.92.0"
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "tf_test" {
    name = "devops-rg"
    location = "southindia"
}

resource "azurerm_container_group" "azuredevopscontainer"{
  name = "azuredevopsapi"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name
  ip_address_type = "public"
  dns_name_label = "swarooprooneydns"
  os_type = "Linux"

  container {
    name   = "hello-world"
    image  = "swarooprooney/azuredevops:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}