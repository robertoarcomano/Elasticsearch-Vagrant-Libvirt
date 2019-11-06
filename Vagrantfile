Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant"
  config.vm.box = "generic/ubuntu1804"
  config.vm.provider :libvirt do |libvirt|
    libvirt.memory = 4096
    libvirt.cpus   = 2
    # libvirt.storage :file, :size => '50G', :type => 'qcow2'
  end
  config.vm.provision "shell" do |s|
    s.path = "script.sh"
  end
  config.vm.define "elasticsearch"
  config.vm.hostname = "elasticsearch"

  # config.vm.define "cephclient" do |cephclient|
  #   cephclient.vm.hostname = "cephclient"
  #   cephclient.vm.network :private_network, ip: "192.168.10.2"
  # end
end
