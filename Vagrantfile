# -*- mode: ruby -*-
# vim: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box_check_update = false
    config.vm.box = "centos/7"
    config.vm.box_version = "2004.01"

    config.vm.provider :virtualbox do |v|
        v.memory = 256
        v.cpus = 1
    end

    config.vm.define "nfss" do |nfss|
        nfss.vm.network "private_network", ip: "192.168.50.10", virtualbox__intnet: "net1"
        nfss.vm.hostname = "nfss"
        nfss.vm.provision "shell", path: "nfss_script.sh"
        nfss.vm.provision "shell", reboot: true
        nfss.vm.provision "shell", inline: <<-SHELL
            ls -la /mnt/upload/
            systemctl status nfs
            systemctl status firewalld
            sudo exportfs -s
            showmount -a 192.168.50.10
        SHELL
    end
    
    config.vm.define "nfsc" do |nfsc|
        nfsc.vm.network "private_network", ip: "192.168.50.11", virtualbox__intnet: "net1"
        nfsc.vm.hostname = "nfsc"
        nfsc.vm.provision "shell", path: "nfsc_script.sh"
        nfsc.vm.provision "shell", reboot: true
        nfsc.vm.provision "shell", inline: <<-SHELL
            showmount -a 192.168.50.10
            ls -la /mnt/upload
            mount | grep mnt
            touch /mnt/upload/final_check
            ls -la /mnt/upload
        SHELL
    end
end