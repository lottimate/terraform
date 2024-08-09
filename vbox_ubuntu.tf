terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

resource "virtualbox_vm" "vm1" {
  name   = "ubuntu 20.04"
  count = 1
  # image  = "https://app.vagrantup.com/ubuntu/boxes/focal64/versions/20240805.0.0/providers/virtualbox/unknown/vagrant.box" # Ubuntu 20.04
  image = "path/to/image"
  cpus   = 2
  memory    = "2048 mib"
  user_data = file("${path.module}/user_data")

  network_adapter {
    type           = "bridged"
    #device         = "IntelPro1000MTDesktop"
    host_interface = "eth0"
    # On Windows use this instead
    # host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

resource "null_resource" "ssh_docker" {
  # Other resource settings  
  connection {
    type        = "ssh"
    user        = "vagrant"
    password = "vagrant"
    #private_key = file("/path/to/your/private/key.pem")
    host        = virtualbox_vm.vm1[0].network_adapter[0].ipv4_address
  }
  provisioner "remote-exec" {
    inline = [ "echo 'Hello World' " ]
  }
}
output "IPAddress" {
  value = element(virtualbox_vm.vm1.*.network_adapter.0.ip4_address, 1)
}