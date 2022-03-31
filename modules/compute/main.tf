

resource "azurerm_network_interface" "web-net-interface" {
    name = "web-network"
    resource_group_name = var.resource_group
    location = var.location

    ip_configuration{
        name = "web-webserver"
        subnet_id = var.web_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_windows_virtual_machine" "web-vm" {
  name = "web-vm"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [ azurerm_network_interface.web-net-interface.id ]
  size = "Standard_D2s_v3"
  admin_username = var.web_username
  admin_password = var.web_os_password
  computer_name = var.web_host_name
  #delete_os_disk_on_termination = true
   os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
    }
   
}
  
resource "azurerm_network_interface" "app-net-interface" {
    name = "app-network"
    resource_group_name = var.resource_group
    location = var.location

    ip_configuration{
        name = "app-webserver"
        subnet_id = var.app_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_windows_virtual_machine" "app-vm" {
  name = "app-vm"
  location = var.location
  resource_group_name = var.resource_group
  network_interface_ids = [ azurerm_network_interface.app-net-interface.id ]
  admin_username = var.app_username
  admin_password = var.app_os_password
  computer_name = var.app_host_name
  #vm_size = "Standard_D2s_v3"
  size = "Standard_D2s_v3"


  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
    }

  
}

