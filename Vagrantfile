# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  
  config.vm.box = "lucid64"

  config.vm.provision :puppet do |puppet|
     puppet.manifests_path = "manifests"
     puppet.manifest_file  = "base-hadoop.pp"
     puppet.module_path = "modules"
  end
  
  config.vm.define :backup do |backup_config|
    backup_config.vm.network :hostonly, "192.168.3.11"
    backup_config.vm.host_name = "backup"
  end
  
  config.vm.define :hadoop1 do |hadoop1_config|
    hadoop1_config.vm.network :hostonly, "192.168.3.12"
    hadoop1_config.vm.host_name = "hadoop1"
  end
  
  config.vm.define :hadoop2 do |hadoop2_config|
    hadoop2_config.vm.network :hostonly, "192.168.3.13"
    hadoop2_config.vm.host_name = "hadoop2"
  end
  
  config.vm.define :hadoop3 do |hadoop3_config|
    hadoop3_config.vm.network :hostonly, "192.168.3.14"
    hadoop3_config.vm.host_name = "hadoop3"
  end
  
   config.vm.define :master do |master_config|
    master_config.vm.share_folder "app", "/home/vagrant/app", "app"

    master_config.vm.forward_port 9000, 9000
    master_config.vm.forward_port 50070, 50070
    
    master_config.vm.network :hostonly, "192.168.3.10"
    master_config.vm.host_name = "master"
  end

end
