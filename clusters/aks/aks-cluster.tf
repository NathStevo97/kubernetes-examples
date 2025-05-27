/* 
This tf file exists to provision an Azure Resource group and an Azure Kubernetes Service Cluster 
*/
resource "random_pet" "prefix" {} #generates a random prefix for resource naming, take out at convenience

#create azure resource group
resource "azurerm_resource_group" "AKS_Demo" {
  name     = "${random_pet.prefix.id}-rg"
  location = var.location

  tags = {
    environment = "Demo"
  }
}
#Create the AKS Cluster
resource "azurerm_kubernetes_cluster" "AKS_Demo" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.AKS_Demo.location
  resource_group_name = azurerm_resource_group.AKS_Demo.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  linux_profile {
    admin_username = "ubuntu"
    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  addon_profile {
    kube_dashboard {
      enabled = true
    }
  }

  tags = {
    environment = "Demo"
  }
}