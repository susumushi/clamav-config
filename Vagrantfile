# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
 
    # Customize the amount of memory on the VM:
    vb.memory = "8192"
    vb.cpus = "4"
  end
  # setup desktop environment
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt install -y ubuntu-desktop
    apt install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
  SHELL

  # for clamav
  config.vm.provision "shell", inline: <<-SHELL
    apt-get install clamav clamav-daemon -y
  SHELL

  # for fangfrisch
  config.vm.provision "shell", inline: <<-SHELL
    apt-get install python3 python3-pip python3-venv -y
  SHELL

end