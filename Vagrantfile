# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "btantlinger/ezlamp"

  #config.vm.network :forwarded_port, guest: 80, host: 8001
  # Create a private network, which allows host-only access to the machine using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.44"

  config.vm.hostname = "ezlamp"

  config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
    
  # Optional NFS. Make sure to remove other synced_folder line too
  #config.vm.synced_folder ".", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }   
  
end
