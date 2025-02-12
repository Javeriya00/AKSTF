provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "my-aks-resource-group"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "myaksdemo"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azuread_application" "gha_app" {
  display_name = "GitHub-OIDC"
}

resource "azuread_service_principal" "gha_sp" {
  client_id = azuread_application.gha_app.client_id
}

resource "azuread_application_federated_identity_credential" "gha_oidc" {
  application_object_id = azuread_application.gha_app.object_id
  display_name          = "GitHub-OIDC"
  issuer               = "https://token.actions.githubusercontent.com"
  subject              = "repo:Javeriya00/AKSTF:ref:refs/heads/main"
  audiences            = ["api://AzureADTokenExchange"]
}
