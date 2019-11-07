Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant"
  config.vm.box = "generic/ubuntu1804"
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 2048
    libvirt.cpus   = 2
  end
  config.vm.provision "shell" do |s|
    s.path = "script.sh"
    s.args = ["elasticnode1"]
  end

  config.vm.define "elasticnode1" do |elasticnode1|
    elasticnode1.vm.hostname = "elasticnode1"
    elasticnode1.vm.network :private_network, ip: "192.168.10.2"
  end

  config.vm.define "elasticnode2" do |elasticnode2|
    elasticnode2.vm.hostname = "elasticnode2"
    elasticnode2.vm.network :private_network, ip: "192.168.10.3"
  end

  config.vm.define "elasticnode3" do |elasticnode3|
    elasticnode3.vm.hostname = "elasticnode3"
    elasticnode3.vm.network :private_network, ip: "192.168.10.4"
  end
end
