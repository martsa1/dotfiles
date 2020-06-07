# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  #################################################################################################
  ################################## Ubuntu #######################################################
  # For complete reference, please see https://docs.vagrantup.com.
  config.vm.define "sm-dev-ubuntu" do |ubuntu|
    config.vm.box = "ubuntu/bionic64"

    config.vm.network "public_network"

    config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true

      # Name the VM in Virtualbox
      vb.name = "sm-dev-ubuntu"

      # Customize the amount of memory on the VM:
      vb.memory = "4096"
      vb.cpus = "4"
    end

    config.vm.provision "shell",
      inline: "apt-get update && apt-get install -y python # && ln -sf /usr/bin/python2 /usr/bin/python"

    config.vm.provision :ansible do |ansible|
      ansible.playbook = "gui_system.yml"
    end
  end
  #################################################################################################

  #################################################################################################
  ###################################### Arch #####################################################
  config.vm.define "sm-dev-arch" do |arch|
    # For complete reference see: https://docs.vagrantup.com.

    config.vm.box = "ogarcia/archlinux-x64"

    config.vm.network "public_network"

    # Provider-specific configuration so you can fine-tune various
    config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = true

      # Name the VM in Virtualbox
      vb.name = "sm-dev-arch"

      # Customize the amount of memory on the VM:
      vb.memory = "4096"
      vb.cpus = "4"
    end

    config.vm.provision "shell",
      inline: "pacman --noconfirm -S python2 && ln -sf /usr/bin/python2 /usr/bin/python"

    config.vm.provision :ansible do |ansible|
      ansible.playbook = "gui_system.yml"
    end
  end
  #################################################################################################

  #################################################################################################
  #################################### Fedora #####################################################
  # config.vm.define "sm-dev-fedora" do |fedora|
  # end
  #################################################################################################
end
